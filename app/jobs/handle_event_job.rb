class HandleEventJob < ApplicationJob
  queue_as :default

  def perform(event)
    event.update(status: 'processing')

    handle_event(event)

    event.update(status: 'processed', processing_errors: '')
  rescue => e
    event.update(status: 'error', processing_errors: e.message)
  end

  def handle_event(event)
    case event.source
    when 'stripe'
      handle_stripe_event(Stripe::Event.construct_from(event['data']))
    else
      raise "Unknown event source: #{event.source}"
    end
  end

  def handle_stripe_event(event)
    case event.type
    when 'customer.subscription.created'
      handle_subscription_created(event)
    else
      raise "Unknown stripe event type: #{event.type}"
    end
  end

  def handle_subscription_created(event)
    subscription = Stripe::Subscription.retrieve(event.data.object.id)
    user = User.find_by(stripe_customer_id: subscription.customer)
    sub = user.subscriptions.find_by(stripe_subscription_id: subscription.id)

    return if !sub.nil?

    fixed_item = subscription.items.data.find {|i| i.price.recurring.usage_type == 'licensed' }
    usage_item = subscription.items.data.find {|i| i.price.recurring.usage_type == 'metered' }
    user.subscriptions.create(
      status: subscription.status,
      stripe_subscription_id: subscription.id,
      fixed_price_id: fixed_item.price.id,
      usage_price_id: usage_item.price.id,
      usage_subscription_item_id: usage_item.id,
    )
  end
end

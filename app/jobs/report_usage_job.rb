class ReportUsageJob < ApplicationJob
  queue_as :default

  def perform(suggestion)
    # Create a usage record in Stripe for the number of tokens used
    subscription = suggestion.user.subscriptions.last
    puts "Reporting usage at #{Time.now.to_i}"
    usage_record = Stripe::SubscriptionItem.create_usage_record(
      subscription.usage_subscription_item_id,
      {
        action: 'set',
        quantity: suggestion.total_tokens,
        timestamp: Time.now.to_i
      },
    )
    suggestion.update!(
      stripe_usage_record_id: usage_record.id,
    )
  end
end

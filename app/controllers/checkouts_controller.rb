class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    # If the user is logged in, then use their stripe customer ID,
    # otherwise, just pass without the customer and Stripe will create
    # a customer object for us.
    checkout_session = Stripe::Checkout::Session.create(
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
      success_url: dashboard_url,
      cancel_url: root_url,
      line_items: [{
        price: 'price_1LYD16FpwM6KCfC6VsbhoNum', # Flat rate per month
        quantity: 1
      }, {
        price: 'price_1LYD1oFpwM6KCfC6V0LglIjk', # Usage based price 0.07 per 1k tokens
      }]
    )

    redirect_to checkout_session.url, allow_other_host: true, status: :see_other
  end
end

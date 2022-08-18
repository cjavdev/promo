class BillingsController < ApplicationController
  before_action :authenticate_user!

  def show
    portal_session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
    })
    redirect_to portal_session.url, allow_other_host: true, status: :see_other
  end
end

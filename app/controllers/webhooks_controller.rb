class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Handle JSON webhook events
    if params[:source].present?
      event = Event.create!(
        source: params[:source],
        data: params
      )
      HandleEventJob.perform_later(event)
      render json: { status: 'ok' }
      return
    end

    # Handle atom notification from pubsubhubbub
    event = YouTubeEvent.create!(
      data: request.body.read,
    )
    YouTubeEventHandlerJob.perform_later(event)
    render json: { status: 'ok' }
  end

  def index
    # verify pubsubhubbub callback
    if params['hub.challenge']
      render plain: params['hub.challenge']
    end
  end
end

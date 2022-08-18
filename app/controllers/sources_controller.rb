require 'google/apis/youtube_v3'
require 'google/api_client/client_secrets'

class SourcesController < ApplicationController
  rescue_from Signet::AuthorizationError, with: :handle_google_auth_error

  def index
    @twitter_connections = current_user.twitter_connections.all
    @you_tube_connections = current_user.you_tube_connections.all
    @channel_ids = current_user.you_tube_channels.pluck(:you_tube_id)
  end

  def handle_google_auth_error
    redirect_to new_you_tube_connection_path
  end
end

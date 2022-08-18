require 'google/api_client/client_secrets'
require 'google/apis/oauth2_v2'

class YouTubeConnectionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @connection = current_user.you_tube_connections.find(params[:id])
  end

  def destroy
    @connection = current_user.you_tube_connections.find(params[:id])
    @connection.destroy
    redirect_to sources_path
  end

  def new
    redirect_to auth_client.authorization_uri.to_s, allow_other_host: true, status: :see_other
  end

  def callback
    auth_client.code = params[:code]
    auth_client.fetch_access_token!
    auth_client.client_secret = nil
    creds = JSON.parse(auth_client.to_json)

    # temporarily save a connection so that
    # we can use it to fetch the user's profile
    s2 = Google::Apis::Oauth2V2::Oauth2Service.new
    s2.authorization = auth_client
    userinfo = s2.get_userinfo

    # Use the creds and profile to find or create the connection.
    connection = current_user.you_tube_connections.find_by(uid: userinfo.id)
    if connection.nil?
      connection = current_user.you_tube_connections.create!(
        uid: userinfo.id,
        credentials: creds,
        name: userinfo.name,
        email: userinfo.email,
      )
    else
      connection.update!(credentials: creds)
    end

    redirect_to connection
  end

  private

  def auth_client
    @auth_client ||= begin
      client_secrets = Google::APIClient::ClientSecrets.new(
        {
          "web": {
            "client_id": Rails.application.credentials.youtube[:client_id],
            "client_secret": Rails.application.credentials.youtube[:client_secret],
            "project_id": Rails.application.credentials.youtube[:project_id],
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "redirect_uris": [redirect_uri]
          }
        }
      )
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        scope: 'email profile https://www.googleapis.com/auth/youtube.force-ssl',
        redirect_uri: redirect_uri,
        additional_parameters: {
          prompt: 'select_account consent',
          access_type: 'offline',
          include_granted_scopes: true,
        }
      )
      auth_client
    end
  end

  def redirect_uri
    url_for(controller: 'you_tube_connections', action: 'callback')
  end
end

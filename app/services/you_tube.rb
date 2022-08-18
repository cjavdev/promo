require 'google/apis/youtube_v3'
require 'google/api_client/client_secrets'

class YouTube
  include Rails.application.routes.url_helpers
  attr_reader :connection

  def initialize(connection:)
    @connection = connection
    refresh_token if @connection.expired?
  end

  def refresh_token
    # returns the refresh token data
    begin
      creds = auth_client.refresh!
      connection.update!(
        credentials: JSON.parse(auth_client.to_json),
        status: :active,
      )
    rescue Signet::AuthorizationError => e
      connection.update!(status: :inactive)
    end
  end

  def fetch_channels
    channels = service.list_channels(
      'id,snippet,brandingSettings,statistics',
      mine: true,
    )
    channels.items
  rescue => e
    p e.class
    []
  end

  def search_videos(page_token: nil)
    service.list_searches(
      'snippet',
      for_mine: true,
      type: 'video',
      page_token: page_token,
      max_results: 10,
      # options: {
      #   authorization: auth_client
      # }
    )
  end

  def fetch_videos(&blk)
    page_token = nil
    loop do
      sr_page = service.list_searches(
        'snippet',
        for_mine: true,
        type: 'video',
        page_token: page_token,
        max_results: 50,
        options: {
          authorization: auth_client
        }
      )
      video_ids = sr_page.items.map do |item|
        item.id.video_id
      end

      videos_page = service.list_videos(
        'snippet',
        id: video_ids,
        options: {
          authorization: auth_client,
        }
      )

      videos_page.items.each do |item|
        blk.call(item)
      end

      page_token = sr_page.next_page_token
      break if page_token.nil?
    end
  end

  def fetch_video(video_id)
    video_list = service.list_videos(
      'snippet,contentDetails,liveStreamingDetails,player,statistics,status',
      id: [video_id],
      options: {
        authorization: auth_client
      }
    )
    if video_list.items.empty?
      raise "Video #{video_id} not found"
    end
    video_list.items.first
  end

  def fetch_captions(video_id)
    caption_id = service
      .list_captions('id', video_id)
      .items
      .first
      .try(:id)

    service.download_caption(caption_id)
  end

  # def update_video(video)
  #   external_video = Google::Apis::YoutubeV3::Video.new(
  #     id: video.youtube_id,
  #     snippet: Google::Apis::YoutubeV3::VideoSnippet.new(
  #       title: video.title,
  #       tags: video.tags,
  #       category_id: 27, # Education
  #       description: video.description,
  #     )
  #   )
  #   service.update_video(
  #     'snippet',
  #     external_video,
  #     options: {
  #       authorization: auth_client
  #     }
  #   )
  # end

  def service
    @service = Google::Apis::YoutubeV3::YouTubeService.new
    @service.authorization = auth_client
    @service
  end

  # def auth_client
  #   @auth_client ||= Signet::OAuth2::Client.new(connection.credentials)
  #   @auth_client.update!(
  #     client_id: Rails.application.credentials.dig(:youtube, :client_id),
  #     client_secret: Rails.application.credentials.dig(:youtube, :client_secret),
  #     additional_parameters: {
  #       'access_type' => 'offline',
  #     }
  #   )
  #   @auth_client
  # end

  def auth_client
    @auth_client ||= begin
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        access_token: connection.credentials['access_token'],
        refresh_token: connection.credentials['refresh_token'],
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

  def client_secrets
    @client_secrets ||= Google::APIClient::ClientSecrets.new(
      web: {
        "client_id": Rails.application.credentials.youtube[:client_id],
        "client_secret": Rails.application.credentials.youtube[:client_secret],
        "project_id": Rails.application.credentials.youtube[:project_id],
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "redirect_uris": [redirect_uri]
      }
    )
  end

  def redirect_uri
    url_for(
      host: ActionMailer::Base.default_url_options[:host],
      controller: 'you_tube_connections',
      action: 'callback'
    )
  end
end

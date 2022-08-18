class Twitter
  BASE_URL = "https://api.twitter.com/2".freeze
  attr_reader :connection

  def initialize(connection)
    @connection = connection
  end

  def me
    params = {
      'user.fields': 'public_metrics',
    }
    get("/users/me", params: params)
  end

  def bookmarks
    params = {
      'tweet.fields': 'created_at',
      'expansions': 'author_id',
      'user.fields': 'profile_image_url',
    }
    get("/users/#{connection.twitter_id}/bookmarks", params: params)
  end

  def tweet(id)
    params = {
      'expansions': 'author_id',
      'media.fields': 'url,public_metrics,media_key,duration_ms,type',
      'tweet.fields': 'entities,attachments,context_annotations,public_metrics,source',
    }
    get("/tweets/#{id}", params: params)
  end

  def post_tweet(text:)
    post("/tweets", body: { text: text })
  end

  def refresh_token!
    headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': "Basic #{secret}",
    }
    response = RestClient.post(
      "#{BASE_URL}/oauth2/token",
      {
        grant_type: 'refresh_token',
        refresh_token: refresh_token,
        client_id: Rails.application.credentials.twitter[:client_id],
      }.to_query,
      headers
    )
    credentials = JSON.parse(response.body, symbolize_names: true)
    connection.update(credentials: credentials)
  rescue => e
    p e.class
    Rails.logger.error e
    JSON.parse(e.response.body, symbolize_names: true)
  end

  def get(path, params: nil)
    params ||= {}
    request(:get, path, params: params)
  end

  def post(path, body: nil)
    body ||= {}
    request(:post, path, body: body)
  end

  def request(method, path, params: nil, body: nil)
    params ||= {}
    body ||= {}

    request_params = {
      method: method,
      url: "#{BASE_URL}#{path}",
      headers: headers.merge(params: params),
    }
    if method == :put || method == :post
      request_params[:payload] = body.to_json
      request_params[:headers]["Content-Type"] = "application/json"
    end

    begin
      response = RestClient::Request.execute(request_params)
      JSON.parse(response.body, symbolize_names: true)
    rescue RestClient::Unauthorized => e
      refresh_token!

      # Lazy retry
      response = RestClient::Request.execute(request_params)
      JSON.parse(response.body, symbolize_names: true)
    rescue => e
      p e.class
      Rails.logger.error e
      JSON.parse(e.response.body, symbolize_names: true)
    end
  end

  def headers
    {
      "Authorization": "Bearer #{token}",
      "User-Agent": "HypeBot Studios",
    }
  end

  def token
    connection.credentials.fetch("token", nil) || connection.credentials.fetch("access_token", nil)
  end

  def refresh_token
    connection.credentials["refresh_token"]
  end

  def secret
    client_id = Rails.application.credentials.twitter[:client_id]
    client_secret = Rails.application.credentials.twitter[:client_secret]
    Base64.strict_encode64("#{client_id}:#{client_secret}")
  end
end

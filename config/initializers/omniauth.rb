Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :twitter2,
    Rails.application.credentials.twitter[:client_id],
    Rails.application.credentials.twitter[:client_secret],
    callback_path: '/auth/twitter2/callback',
    scope: "tweet.read tweet.write users.read bookmark.read offline.access"
  )
end

OmniAuth.config.allowed_request_methods = %i[get]

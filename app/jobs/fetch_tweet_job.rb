class FetchTweetJob < ApplicationJob
  queue_as :default

  def perform(tweet)
    return if tweet.text.present?
    t = Twitter.new(tweet.user.twitter_connections.first)
    response = t.tweet(tweet.twitter_id)
    tweet.update!(
      name: response[:includes][:users].first[:name],
      username: response[:includes][:users].first[:username],
      text: response[:data][:text],
      data: response
    )
  end
end

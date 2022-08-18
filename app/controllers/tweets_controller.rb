class TweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    twitter = current_user.twitter_connections.first.service
    twitter.post_tweet(
      text: tweet_params[:text],
    )
    redirect_back fallback_location: sources_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text)
  end
end

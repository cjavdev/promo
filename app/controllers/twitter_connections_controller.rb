class TwitterConnectionsController < ApplicationController
  before_action :authenticate_user!

  def show
    @connection = current_user.twitter_connections.find(params[:id])
    trained_tweet_ids = current_user.training_samples.includes(:tweet).pluck('tweets.twitter_id')
    @bookmarks = @connection.bookmarks.filter do |mark|
      !trained_tweet_ids.include?(mark.tweet_id)
    end
  end

  def create
    auth = request.env['omniauth.auth']
    connection = current_user.twitter_connections.find_by(
      twitter_id: auth['uid'],
    )
    if connection.nil?
      connection = current_user.twitter_connections.create(
        twitter_id: auth['uid'],
        status: :active,
        username: auth['info']['nickname'],
        credentials: auth['credentials'],
      )
    end

    redirect_to dashboard_path
  end
end

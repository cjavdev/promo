class TrainingSamplesController < ApplicationController
  before_action :authenticate_user!

  def index
    @samples = current_user.training_samples.order(created_at: :desc)
  end

  def show
    @sample = current_user.training_samples.find(params[:id])
  end

  def create
    @tweet = current_user.tweets.find_or_create_by(twitter_id: training_sample_params[:tweet_id])
    FetchTweetJob.perform_now(@tweet)
    if @tweet.parsed_video_id.present?
      @video = current_user.training_videos.find_or_create_by(video_id: @tweet.parsed_video_id)
      @sample = current_user.training_samples.new(tweet: @tweet, training_video: @video)

      if @sample.save
        FetchTrainingVideoJob.perform_later(@video)
        redirect_to @sample
        return
      else
        flash[:error] = @sample.errors.full_messages.join(', ')
      end
    else
      flash[:error] = 'No video ID found in tweet'
    end
    redirect_back fallback_location: training_samples_path
  end

  private

  def training_sample_params
    params.require(
      :training_sample
    ).permit(
      :tweet_id
    )
  end
end

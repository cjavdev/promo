class YouTubeVideosController < ApplicationController
  def index
    connection = current_user.you_tube_videos.all
    @videos = current_user.you_tube_videos.order(updated_at: :desc)
  end

  def create
    video = current_user.you_tube_videos.new(video_params)

    if !video.save
      flash[:errors] = video.errors.full_messages
    end

    redirect_to you_tube_video_path(video.you_tube_id)
  end

  def update
    video = current_user.you_tube_videos.find_by(you_tube_id: params[:id])
    video.update(video_update_params)
    redirect_to you_tube_video_path(video)
  end

  def show
    @destination = Destination.find_by(id: params[:destination_id]) || Destination.first
    @video = current_user.you_tube_videos.find_by(you_tube_id: params[:id])
    @video.fetch_if_stale!
    @suggestions = @video.suggestions.where(destination_id: @destination.id).order(id: :desc)
  end

  private

  def video_update_params
    params.require(:video).permit(:custom_captions)
  end

  def video_params
    params.require(:video).permit(
      :title,
      :you_tube_id,
      :you_tube_channel_id,
      :you_tube_connection_id,
    )
  end
end

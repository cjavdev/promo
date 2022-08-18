class YouTubeChannelsController < ApplicationController
  def show
    @channel = current_user.you_tube_channels.find_by!(you_tube_id: params[:id])
    service = YouTube.new(connection: @channel.you_tube_connection)
    @videos = service.search_videos(page_token: params[:page_token])
    @promoted_video_ids = current_user.you_tube_videos.pluck(:you_tube_id)
  end

  def create
    @channel = current_user.you_tube_channels.new(channel_params)

    # Security check that someone isn't trying to use another users connection.
    if !current_user.you_tube_connection_ids.include?(@channel.you_tube_connection_id)
      flash[:error] = @channel.errors.full_messages.join(', ')
      return
    elsif !@channel.save
      flash[:error] = @channel.errors.full_messages.join(', ')
    end

    redirect_to sources_path
  end

  def destroy
    @channel = current_user.you_tube_channels.find_by(you_tube_id: params[:id])
    @channel.try(:destroy)
    redirect_to sources_path
  end

  private

  def channel_params
    params.require(:channel).permit(
      :you_tube_id,
      :banner_url,
      :custom_url,
      :keywords,
      :subscriber_count,
      :video_count,
      :view_count,
      :title,
      :you_tube_connection_id,
    )
  end
end

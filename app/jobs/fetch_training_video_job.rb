class FetchTrainingVideoJob < ApplicationJob
  queue_as :default

  def perform(video)
    you_tube = video
      .user
      .you_tube_connections
      .where(status: 'active')
      .first.try(:service)
    if you_tube.nil?
      Rails.logger.error "No YouTube connection for user #{video.user.id}"
    end

    data = you_tube.fetch_video(video.video_id)

    video.update!(
      data: data
    )
  end
end

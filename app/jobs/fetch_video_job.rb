class FetchVideoJob < ApplicationJob
  queue_as :default

  def perform(you_tube_video)
    @you_tube_video = you_tube_video

    @you_tube_video.update!(
      fetch_status: :fetched,
      fetched_at: Time.now,
      data: video.to_h,
      description: video.snippet.description,
      tags: video.snippet.tags,
      title: video.snippet.title,
    )
    begin
      @you_tube_video.update!(captions: captions)
    rescue => e
      puts "Unable to fetch captions for this video"
    end
  rescue => e
    @you_tube_video.update!(
      fetch_status: :failed,
      fetch_errors: e.message
    )
  end

  def captions
    @captions ||= service.fetch_captions(@you_tube_video.you_tube_id)
  end

  def video
    @video ||= service.fetch_video(@you_tube_video.you_tube_id)
  end

  def service
    @service ||= YouTube.new(connection: @you_tube_video.you_tube_connection)
  end
end

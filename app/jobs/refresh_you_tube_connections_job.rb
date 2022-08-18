class RefreshYouTubeConnectionsJob < ApplicationJob
  queue_as :default

  def perform
    YouTubeConnection.all.each do |connection|
      RefreshYouTubeConnectionJob.perform_later(connection)
    end
  end
end

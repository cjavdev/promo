class RefreshYouTubeConnectionJob < ApplicationJob
  queue_as :default

  def perform(connection)
    YouTube.new(connection: connection).refresh_token
  end
end

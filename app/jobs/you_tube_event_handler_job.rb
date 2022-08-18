class YouTubeEventHandlerJob < ApplicationJob
  queue_as :default

  def perform(event)
    puts "YouTubeEventHandlerJob: #{event.data}"
    # Find or create a new youtube video by ID
    # If the video already exists, update it with the new data
    # else create it
  end
end

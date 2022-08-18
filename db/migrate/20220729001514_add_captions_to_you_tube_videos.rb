class AddCaptionsToYouTubeVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_videos, :captions, :text
  end
end

class AddStatusToYouTubeVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_videos, :status, :integer, default: 0, null: false
  end
end

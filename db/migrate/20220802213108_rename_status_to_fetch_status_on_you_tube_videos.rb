class RenameStatusToFetchStatusOnYouTubeVideos < ActiveRecord::Migration[7.1]
  def change
    rename_column :you_tube_videos, :status, :fetch_status
  end
end

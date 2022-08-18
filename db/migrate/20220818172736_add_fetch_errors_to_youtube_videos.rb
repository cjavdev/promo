class AddFetchErrorsToYoutubeVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_videos, :fetch_errors, :text
  end
end

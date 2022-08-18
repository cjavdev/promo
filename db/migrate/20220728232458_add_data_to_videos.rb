class AddDataToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_videos, :fetched_at, :datetime
    add_column :you_tube_videos, :tags, :text, array: true, default: []
    add_column :you_tube_videos, :description, :text
    add_column :you_tube_videos, :data, :json
  end
end

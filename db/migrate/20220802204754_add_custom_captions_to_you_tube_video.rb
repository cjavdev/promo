class AddCustomCaptionsToYouTubeVideo < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_videos, :custom_captions, :text
  end
end

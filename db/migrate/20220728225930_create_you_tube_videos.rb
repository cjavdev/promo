class CreateYouTubeVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :you_tube_videos do |t|
      t.string :you_tube_id, null: false
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.references :you_tube_channel, null: false, foreign_key: true
      t.references :you_tube_connection, null: false, foreign_key: true

      t.timestamps
    end
    add_index :you_tube_videos, :you_tube_id
    add_index :you_tube_videos, [:user_id, :you_tube_id], unique: true
  end
end

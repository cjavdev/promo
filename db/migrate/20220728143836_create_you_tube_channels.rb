class CreateYouTubeChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :you_tube_channels do |t|
      t.string :you_tube_id, null: false
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :custom_url
      t.integer :view_count
      t.integer :subscriber_count
      t.integer :video_count

      t.timestamps
    end
    add_index :you_tube_channels, :you_tube_id
    add_index :you_tube_channels, [:user_id, :you_tube_id], unique: true
  end
end

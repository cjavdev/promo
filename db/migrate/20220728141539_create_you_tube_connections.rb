class CreateYouTubeConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :you_tube_connections do |t|
      t.json :credentials
      t.references :user, null: false, foreign_key: true
      t.string :uid, null: false
      t.string :name, null: false
      t.string :photo_url, null: false

      t.timestamps
    end
  end
end

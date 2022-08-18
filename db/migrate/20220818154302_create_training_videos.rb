class CreateTrainingVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :training_videos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :video_id
      t.json :data

      t.timestamps
    end
  end
end

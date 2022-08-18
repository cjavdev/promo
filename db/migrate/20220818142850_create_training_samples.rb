class CreateTrainingSamples < ActiveRecord::Migration[7.1]
  def change
    create_table :training_samples do |t|
      t.references :user, null: false, foreign_key: true
      t.string :tweet_id
      t.string :tweet_content
      t.string :video_id
      t.string :video_title
      t.string :video_description
      t.string :video_tags

      t.timestamps
    end
  end
end

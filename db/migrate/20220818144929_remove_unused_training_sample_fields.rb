class RemoveUnusedTrainingSampleFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :training_samples, :tweet_data
    remove_column :training_samples, :video_data
    remove_column :training_samples, :video_description
    remove_column :training_samples, :video_tags
    remove_column :training_samples, :video_title
    remove_column :training_samples, :tweet_content
    remove_column :training_samples, :tweet_id
    remove_column :training_samples, :video_id
  end
end

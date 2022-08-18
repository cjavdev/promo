class AddTweetDataToTrainingSamples < ActiveRecord::Migration[7.1]
  def change
    add_column :training_samples, :tweet_data, :json
    add_column :training_samples, :video_data, :json
  end
end

class AddTweetAndVideoReferenceToTrainingSamples < ActiveRecord::Migration[7.1]
  def change
    add_reference :training_samples, :tweet, null: false, foreign_key: true
    add_reference :training_samples, :you_tube_video, null: false, foreign_key: true
  end
end

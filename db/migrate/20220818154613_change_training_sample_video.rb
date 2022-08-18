class ChangeTrainingSampleVideo < ActiveRecord::Migration[7.1]
  def change
    remove_column :training_samples, :you_tube_video_id
    add_reference :training_samples, :training_video, null: false, foreign_key: true
  end
end

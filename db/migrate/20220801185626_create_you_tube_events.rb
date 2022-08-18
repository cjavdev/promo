class CreateYouTubeEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :you_tube_events do |t|
      t.text :data
      t.integer :status, default: 0
      t.string :processing_errors

      t.timestamps
    end
  end
end

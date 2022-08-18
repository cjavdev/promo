class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.json :data
      t.integer :status, default: 0
      t.text :processing_errors
      t.string :source

      t.timestamps
    end
  end
end

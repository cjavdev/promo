class CreateSuggestions < ActiveRecord::Migration[7.1]
  def change
    create_table :suggestions do |t|
      t.references :you_tube_video, null: false, foreign_key: true
      t.text :content
      t.references :destination, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateDestinations < ActiveRecord::Migration[7.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.integer :max_length

      t.timestamps
    end
  end
end

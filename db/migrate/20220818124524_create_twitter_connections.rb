class CreateTwitterConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :twitter_connections do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.json :credentials
      t.string :username
      t.string :twitter_id

      t.timestamps
    end
  end
end

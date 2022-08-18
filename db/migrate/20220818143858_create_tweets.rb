class CreateTweets < ActiveRecord::Migration[7.1]
  def change
    create_table :tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :username
      t.string :text
      t.string :twitter_id
      t.datetime :tweeted_at
      t.json :data

      t.timestamps
    end
  end
end

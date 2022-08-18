class CreateWaitlistUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :waitlist_users do |t|
      t.string :email, null: false
      t.string :you_tube_channel_url

      t.timestamps
    end
  end
end

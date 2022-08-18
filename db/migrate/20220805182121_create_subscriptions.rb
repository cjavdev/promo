class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :stripe_subscription_id, null: false
      t.string :fixed_price_id
      t.string :usage_price_id
      t.string :usage_subscription_item_id
      t.string :status

      t.timestamps
    end
  end
end

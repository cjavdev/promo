# == Schema Information
#
# Table name: subscriptions
#
#  id                         :bigint           not null, primary key
#  status                     :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  fixed_price_id             :string
#  stripe_subscription_id     :string           not null
#  usage_price_id             :string
#  usage_subscription_item_id :string
#  user_id                    :bigint           not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user
end

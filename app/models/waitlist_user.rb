# == Schema Information
#
# Table name: waitlist_users
#
#  id                   :bigint           not null, primary key
#  email                :string           not null
#  you_tube_channel_url :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class WaitlistUser < ApplicationRecord
end

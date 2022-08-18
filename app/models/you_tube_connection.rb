# == Schema Information
#
# Table name: you_tube_connections
#
#  id          :bigint           not null, primary key
#  credentials :json
#  email       :string
#  name        :string
#  status      :integer          default("inactive"), not null
#  uid         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_you_tube_connections_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class YouTubeConnection < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  encrypts :credentials
  belongs_to :user

  def expired?
    Time.at(credentials['expires_at']) < Time.now
  end

  def service
    @service ||= YouTube.new(connection: self)
  end

  def channels
    @channels ||= YouTube.new(connection: self).fetch_channels
  end
end

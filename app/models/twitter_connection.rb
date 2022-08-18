# == Schema Information
#
# Table name: twitter_connections
#
#  id          :bigint           not null, primary key
#  credentials :json
#  status      :integer
#  username    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  twitter_id  :string
#  user_id     :bigint           not null
#
# Indexes
#
#  index_twitter_connections_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class TwitterConnection < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  encrypts :credentials
  belongs_to :user

  def service
    Twitter.new(self)
  end

  def public_metrics
    @metrics ||= service.me[:data][:public_metrics]
  end

  def bookmarks
    Bookmark.from_response(service.bookmarks)
  end
end

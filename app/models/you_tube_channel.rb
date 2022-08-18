# == Schema Information
#
# Table name: you_tube_channels
#
#  id                     :bigint           not null, primary key
#  banner_url             :string
#  custom_url             :string
#  keywords               :text             default([]), is an Array
#  subscriber_count       :integer
#  title                  :string
#  video_count            :integer
#  view_count             :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#  you_tube_connection_id :bigint           not null
#  you_tube_id            :string           not null
#
# Indexes
#
#  index_you_tube_channels_on_user_id                  (user_id)
#  index_you_tube_channels_on_user_id_and_you_tube_id  (user_id,you_tube_id) UNIQUE
#  index_you_tube_channels_on_you_tube_connection_id   (you_tube_connection_id)
#  index_you_tube_channels_on_you_tube_id              (you_tube_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (you_tube_connection_id => you_tube_connections.id)
#
class YouTubeChannel < ApplicationRecord
  belongs_to :user
  belongs_to :you_tube_connection
end

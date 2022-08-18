# == Schema Information
#
# Table name: you_tube_videos
#
#  id                     :bigint           not null, primary key
#  captions               :text
#  custom_captions        :text
#  data                   :json
#  description            :text
#  fetch_errors           :text
#  fetch_status           :integer          default("pending"), not null
#  fetched_at             :datetime
#  tags                   :text             default([]), is an Array
#  title                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :bigint           not null
#  you_tube_channel_id    :bigint           not null
#  you_tube_connection_id :bigint           not null
#  you_tube_id            :string           not null
#
# Indexes
#
#  index_you_tube_videos_on_user_id                  (user_id)
#  index_you_tube_videos_on_user_id_and_you_tube_id  (user_id,you_tube_id) UNIQUE
#  index_you_tube_videos_on_you_tube_channel_id      (you_tube_channel_id)
#  index_you_tube_videos_on_you_tube_connection_id   (you_tube_connection_id)
#  index_you_tube_videos_on_you_tube_id              (you_tube_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (you_tube_channel_id => you_tube_channels.id)
#  fk_rails_...  (you_tube_connection_id => you_tube_connections.id)
#
class YouTubeVideo < ApplicationRecord
  enum fetch_status: { pending: 0, fetching: 1, fetched: 2, failed: 3, }
  belongs_to :user
  belongs_to :you_tube_channel
  belongs_to :you_tube_connection
  has_many :suggestions

  after_commit on: :update do
    broadcast_replace locals: { video: self }
  end

  def stale?
    fetched_at.nil? || fetched_at < 1.day.ago
  end

  def fetch_if_stale!
    fetch! if stale?
  end

  def fetch!
    update(fetch_status: :fetching) if pending?
    FetchVideoJob.perform_later(self)
  end

  def to_param
    you_tube_id
  end

  def url
    "https://youtu.be/#{you_tube_id}"
  end

  def parsed_or_custom_captions
    custom_captions || parsed_captions
  end

  def parsed_captions
    # Parsed captions from YouTube
    @parsed_captions ||= Caption.parse(captions)
  end

  def _data
    data || {}
  end

  def duration
    ActiveSupport::Duration.parse(_data["content_details"]["duration"])
  end

  def view_count
    _data["statistics"]["view_count"]
  end

  def like_count
    _data["statistics"]["like_count"]
  end

  def comment_count
    _data["statistics"]["comment_count"]
  end

  def published_at
    _data["snippet"]["published_at"]
  end

  def thumbnail_url
    _data["snippet"]["thumbnails"]["high"]["url"]
  end
end

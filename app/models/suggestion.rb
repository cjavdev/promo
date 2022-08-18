# == Schema Information
#
# Table name: suggestions
#
#  id                     :bigint           not null, primary key
#  completion_tokens      :integer
#  content                :text
#  data                   :json
#  prompt_tokens          :integer
#  total_tokens           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  destination_id         :bigint           not null
#  stripe_usage_record_id :string
#  you_tube_video_id      :bigint           not null
#
# Indexes
#
#  index_suggestions_on_destination_id     (destination_id)
#  index_suggestions_on_you_tube_video_id  (you_tube_video_id)
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => destinations.id)
#  fk_rails_...  (you_tube_video_id => you_tube_videos.id)
#
class Suggestion < ApplicationRecord
  belongs_to :you_tube_video
  belongs_to :destination
  has_one :user, through: :you_tube_video

  after_commit on: :update do
    broadcast_update_to [you_tube_video, :suggestions], target: self
  end

  after_commit on: :create do
    generate!
  end

  def generate!
    CreateCompletionJob.perform_later(self)
  end

  def prompt
    @prompt ||= Prompt.create(self)
  end

  def draft_content
    "#{content.try(:strip)} #{you_tube_video.url}"
  end
end

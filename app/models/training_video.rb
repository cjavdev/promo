# == Schema Information
#
# Table name: training_videos
#
#  id         :bigint           not null, primary key
#  data       :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#  video_id   :string
#
# Indexes
#
#  index_training_videos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class TrainingVideo < ApplicationRecord
  belongs_to :user

  def snippet
    (data || {}).fetch('snippet', {})
  end

  def title
    snippet.fetch('title', '')
  end

  def description
    snippet.fetch('description', '')
  end

  def tags
    snippet.fetch('tags', [])
  end
end

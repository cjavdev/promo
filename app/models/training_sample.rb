# == Schema Information
#
# Table name: training_samples
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  training_video_id :bigint           not null
#  tweet_id          :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_training_samples_on_training_video_id  (training_video_id)
#  index_training_samples_on_tweet_id           (tweet_id)
#  index_training_samples_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (training_video_id => training_videos.id)
#  fk_rails_...  (tweet_id => tweets.id)
#  fk_rails_...  (user_id => users.id)
#
class TrainingSample < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :training_video

  delegate :title, :description, :tags, to: :training_video
  delegate :text, :name, :username, to: :tweet

  def prompt
    <<~TEXT
    Generate a tweet for this video given its title, description, and tags.
    TITLE: #{title}
    DESCRIPTION: #{description.gsub("\n", " ")}
    TAGS: #{tags.join(",")}
    TWEET:
    TEXT
  end

  def answer
    text.gsub(/https:\/\/t.co\/(\w+)/, "").strip
  end
end

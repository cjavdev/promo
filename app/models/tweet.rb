# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  data       :json
#  name       :string
#  text       :string
#  tweeted_at :datetime
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  twitter_id :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tweets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Tweet < ApplicationRecord
  belongs_to :user

  def parsed_video_id
    uri = URI.parse(unwound_url)
    if uri.host == "youtu.be"
      uri.path.split("/").last
    else
      if uri.query
        Hash[URI.decode_www_form(uri.query)]["v"]
      end
    end
  end

  def unwound_url
    data
      .dig("data", "entities", "urls")
      .find { |url| url["unwound_url"].include?("youtu")}
      .dig("unwound_url")
  end

  def name
    data['includes']['users'].first['name']
  end

  def username
    data['includes']['users'].first['username']
  end
end

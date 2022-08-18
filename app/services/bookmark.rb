class Bookmark
  def self.from_response(response)
    authors = response[:includes][:users].inject({}) do |acc, user|
      acc[user[:id]] = user
      acc
    end

    response[:data].map do |tweet|
      author = authors[tweet[:author_id]]
      Bookmark.new(tweet.merge(author: author))
    end
  end

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def tweet_id
    data[:id]
  end

  def text
    data[:text]
  end

  def created_at
    data[:created_at]
  end

  def username
    data[:author][:username]
  end

  def name
    data[:author][:name]
  end

  def profile_image_url
    data[:author][:profile_image_url]
  end
end

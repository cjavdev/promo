class BlogPostPrompt < Prompt
  def to_s
    "#{request} #{goal} #{context}"
  end

  def request
    "Write a short blog post for developers on dev.to"
  end

  def goal
    "about this youtube video #{suggestion.you_tube_video.url}"
  end

  def context
    "given its transcript:\n\n#{script}."
  end
end

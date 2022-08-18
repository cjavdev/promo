class LinkedInPostPrompt < Prompt
  def to_s
    "#{request} #{goal} #{context}"
  end

  def request
    "Write a professional linkedin post"
  end

  def goal
    "to promote this link #{suggestion.you_tube_video.url}"
  end

  def context
    "given this introduction:\n\n#{script}."
  end
end

class YouTubeDescriptionPrompt < Prompt
  def to_s
    "#{request} #{context}"
  end

  def request
    "Summarize the content of this video"
  end

  def context
    "given this transcript:\n\n#{script}."
  end
end

class Prompt
  attr_reader :suggestion

  def initialize(suggestion)
    @suggestion = suggestion
  end

  def to_s
    # Subclasses of Prompt must implement `to_s`
    raise NotImplementedError
  end

  def self.create(suggestion)
    "#{suggestion.destination.kind}Prompt".constantize.new(suggestion)
  end

  def script
    suggestion
      .you_tube_video
      .parsed_or_custom_captions
      .truncate_words(500)[0..-3]
  end
end

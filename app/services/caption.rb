class Caption
  TIME_CODE = /^(\d{1,}:)?\d{2}:\d{2}.\d{3}.*(\d{2}:)?\d{2}:\d{2}.\d{3}/

  def self.parse(text)
    return '' if text.nil?
    text
      .split("\n")
      .filter {|line| !line.match?(TIME_CODE)}
      .join(" ")
      .gsub(/ uh /, ' ')
      .gsub(/ um /, ' ')
      .gsub(/  /, ' ')
  end
end

# == Schema Information
#
# Table name: destinations
#
#  id         :bigint           not null, primary key
#  max_length :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Destination < ApplicationRecord
  def kind
    name
      .split(/ /)
      .map(&:titleize)
      .map(&:split)
      .flatten
      .join
  end
end

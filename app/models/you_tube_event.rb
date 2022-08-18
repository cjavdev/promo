# == Schema Information
#
# Table name: you_tube_events
#
#  id                :bigint           not null, primary key
#  data              :text
#  processing_errors :string
#  status            :integer          default("pending")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class YouTubeEvent < ApplicationRecord
  enum status: {
    pending: 0,
    processing: 1,
    processed: 2,
    error: 3
  }
end

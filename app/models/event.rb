# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  data              :json
#  processing_errors :text
#  source            :string
#  status            :integer          default("pending")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Event < ApplicationRecord
  enum status: {
    pending: 0,
    processing: 1,
    processed: 2,
    error: 3
  }
end

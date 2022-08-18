class AddUsageRecordIdToSuggestions < ActiveRecord::Migration[7.1]
  def change
    add_column :suggestions, :stripe_usage_record_id, :string
  end
end

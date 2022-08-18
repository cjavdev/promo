class AddUsageToSuggestions < ActiveRecord::Migration[7.1]
  def change
    add_column :suggestions, :prompt_tokens, :integer
    add_column :suggestions, :completion_tokens, :integer
    add_column :suggestions, :total_tokens, :integer
    add_column :suggestions, :data, :json
  end
end

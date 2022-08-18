class AddConnectionStatusToYouTubeConnections < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_connections, :status, :integer, default: 0, null: false
  end
end

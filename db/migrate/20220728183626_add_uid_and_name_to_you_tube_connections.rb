class AddUidAndNameToYouTubeConnections < ActiveRecord::Migration[7.1]
  def change
    add_column :you_tube_connections, :uid, :string
    add_column :you_tube_connections, :name, :string
    add_column :you_tube_connections, :email, :string
  end
end

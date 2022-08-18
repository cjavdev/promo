class ChangeChannelAndConnection < ActiveRecord::Migration[7.1]
  def change
    remove_column :you_tube_connections, :name
    remove_column :you_tube_connections, :photo_url
    remove_column :you_tube_connections, :uid

    add_column :you_tube_channels, :banner_url, :string
    add_column :you_tube_channels, :keywords, :text, array: true, default: []
  end
end

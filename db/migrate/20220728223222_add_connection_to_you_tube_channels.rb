class AddConnectionToYouTubeChannels < ActiveRecord::Migration[7.1]
  def change
    add_reference :you_tube_channels, :you_tube_connection, null: false, foreign_key: true
  end
end

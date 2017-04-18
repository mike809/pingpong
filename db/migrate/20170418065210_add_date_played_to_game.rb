class AddDatePlayedToGame < ActiveRecord::Migration
  def change
    add_column :games, :date_played, :date
  end
end

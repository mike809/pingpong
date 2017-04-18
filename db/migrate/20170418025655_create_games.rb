class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player_1, index: true, foreign_key: true
      t.references :player_2, index: true, foreign_key: true
      t.integer :player_1_score
      t.integer :player_2_score

      t.timestamps null: false
    end
  end
end

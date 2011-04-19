class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.timestamp :date
      t.integer :player1_points
      t.integer :player2_points

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end

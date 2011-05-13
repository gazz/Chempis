class TournamentUsers < ActiveRecord::Migration
  def self.up
    create_table :tournament_users do |t|
      t.references :tournament, :null => false
      t.references :user, :null => false
    end
    
    add_column :tournaments, :available_spots, :integer
    add_column :tournaments, :location, :string
    
  end

  def self.down
    drop_table :tournament_users
    remove_column :tournaments, :available_spots
    remove_column :tournaments, :location, :string
  end
end

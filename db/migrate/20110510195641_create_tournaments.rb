class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.string :name
      t.timestamp :datetime

      t.timestamps
    end
    
    change_table :games do |t|
      t.belongs_to :tournament
    end
    
    add_index :games, :tournament_id
    
  end

  def self.down
    remove_index :games, :tournament_id
    drop_table :tournaments
    remove_column :games, :tournament_id
  end
end

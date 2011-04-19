class CreateKarts < ActiveRecord::Migration
  def self.up
    create_table :karts do |t|
      t.integer :laptime
      t.timestamp :date
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :karts
  end
end

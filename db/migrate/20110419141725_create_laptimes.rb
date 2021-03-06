class CreateLaptimes < ActiveRecord::Migration
  def self.up
    create_table :laptimes do |t|
      t.integer :laptime
      t.timestamp :date
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :laptimes
  end
end

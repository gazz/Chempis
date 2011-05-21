class Tournament < ActiveRecord::Base
  has_many :games, :dependent => :destroy

  has_many :tournament_users
  has_many :users, :through => :tournament_users, :uniq=>true
  
  validates_presence_of :name, :datetime, :available_spots, :location,
    :message => "sapildam ka nu visus laukus"
  
  def self.upcoming
    where('datetime > ?', DateTime.now)
  end
  
  def self.previous
    where('datetime < ?', DateTime.now)
  end
  
end

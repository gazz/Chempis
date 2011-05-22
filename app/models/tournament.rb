class Tournament < ActiveRecord::Base
  has_many :games, :dependent => :destroy

  has_many :tournament_users
  has_many :users, :through => :tournament_users, :uniq=>true
  
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  
  validates_presence_of :name, :datetime, :available_spots, :location, :owner,
    :message => "sapildam ka nu visus laukus"
  
  def self.upcoming
    where('datetime > ?', DateTime.now)
  end
  
  def self.previous
    where('datetime < ?', DateTime.now)
  end
  
end

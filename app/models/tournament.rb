class Tournament < ActiveRecord::Base
  has_many :games, :dependent => :destroy

  has_many :tournament_users
  has_many :users, :through => :tournament_users, :uniq=>true
  
  
end

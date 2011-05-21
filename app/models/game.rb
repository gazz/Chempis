class Game < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :player1,  :class_name => 'User', :foreign_key => 'player1_id'
  belongs_to :player2,  :class_name => 'User', :foreign_key => 'player2_id'
  
  validates_numericality_of :player1_points, :player2_points, :only_integer=> true,
    :greater_than_or_equal_to => 0, :less_than_or_equal_to => 23,
    :message => 'Punktiem jābūt robežās no 0..23'
    
  validates_presence_of :player1_id, :player2_id,
    :message => 'Kas ta tā par štelli bez sportista?'

  def self.find_by_player(player_id)
    order('created_at desc').where("player1_id = :player_id OR player2_id = :player_id", 
      {:player_id => player_id} )
  end
  
  def self.find_by_players(player1_id, player2_id)
    order('created_at desc').where("(player1_id = :player1_id AND player2_id = :player2_id) OR " +
      " (player1_id = :player2_id AND player2_id = :player1_id)",
      { :player1_id => player1_id, :player2_id => player2_id } )
  end
  
end

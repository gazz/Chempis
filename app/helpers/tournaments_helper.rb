module TournamentsHelper
  
  def games
    @games ||= Game.find_all_by_player1_id(current_user.id) + 
      Game.find_all_by_player2_id(current_user.id)
  end
  
  def total_games
    games.count
  end
  
  def games_won
    games.reduce(0) do |wins, game| 
      if game.player1_id==current_user.id && game.player1_points>game.player2_points
        wins += 1
      elsif game.player2_id==current_user.id && game.player2_points>game.player1_points
        wins += 1
      end
      wins
    end
  end
  
  def games_lost
    games.reduce(0) do |loses, game| 
      if game.player1_id==current_user.id && game.player1_points<=game.player2_points
        loses += 1
      elsif game.player2_id==current_user.id && game.player2_points<=game.player1_points
        loses += 1
      end
      loses
    end
  end
  
end

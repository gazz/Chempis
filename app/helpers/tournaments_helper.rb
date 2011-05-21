module TournamentsHelper
  
  def games
    @current_user_games ||= Game.find_by_player(current_user.id)
  end
  
  def total_games
    games.count
  end
  
  def games_won
    GamesCalculator::calc_wins(games, current_user)
  end
  
  def games_lost
    GamesCalculator::calc_loses(games, current_user)
  end
  
end

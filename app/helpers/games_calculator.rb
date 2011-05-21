module GamesCalculator
  
  def self.calc_wins(games, user)
    games.reduce(0) do |wins, game| 
      if game.player1_id==user.id && game.player1_points>game.player2_points
        wins += 1
      elsif game.player2_id==user.id && game.player2_points>game.player1_points
        wins += 1
      end
      wins
    end
  end
  
  def self.calc_loses(games, user)
    games.reduce(0) do |loses, game| 
      if game.player1_id==user.id && game.player1_points<=game.player2_points
        loses += 1
      elsif game.player2_id==user.id && game.player2_points<=game.player1_points
        loses += 1
      end
      loses
    end
  end
  
  def self.calc_tournament_standings(tournament)
    users = tournament.users
    games = tournament.games
    # sort them by tournament games won
    user_points = {}
    users.each do |user| 
      user_points[user.id] = self.calc_wins(games, user)
    end
    
    users.sort! { |a,b| user_points[b.id] <=> user_points[a.id] }
  end
  
  def self.calc_games_against_opponent(games, user)
    # returns hash - [:total => x, :wins => x, losses => x]
    {:total => games.count, :wins => self.calc_wins(games, user), 
      :loses => self.calc_loses(games, user)}
  end
  
  def self.game_winner(game)
    if game.player1_points > game.player2_points
      game.player1
    else
      game.player2
    end
  end
  
end
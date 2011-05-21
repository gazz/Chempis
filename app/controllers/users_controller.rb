class UsersController < ApplicationController
  
  def show
    if params[:current]
      @user = current_user
    else
      @user = User.find(params[:id])
    end
    
    @games = Game.find_by_player(@user.id)
    
    @tournaments_total = @user.tournaments.count
    
    # calc tournament standings
    @tournament_best = nil
    @tournament_worst = nil
    
    @user.tournaments.each do |tournament|
      standings = GamesCalculator::calc_tournament_standings(tournament);
      place = standings.index(@user) + 1
      @tournament_best ||= place
      @tournament_worst ||= place
      if place < @tournament_best 
        @tournament_best = place
      end
      if place > @tournament_worst 
        @tournament_worst = place
      end
    end
    
    @opponents = User.all - [@user]
    @opponent_res = {}
    @opponents.each do |o|
      op_games = Game.find_by_players(@user.id, o.id)
      @opponent_res[o] = GamesCalculator::calc_games_against_opponent(op_games, @user)
    end
    
    render '/user/show'
  rescue ActiveRecord::RecordNotFound:
      flash[:notice] = 'Lietotājs neeksistē'
      redirect_to root_path
  end
  
  def vs
    @user = User.find(params[:id])
    @opponent = User.find(params[:vs_id])
    @games = Game.find_by_players(@user.id, @opponent.id)
    render '/user/vs'
  rescue ActiveRecord::RecordNotFound
    redirect_to :back
  end
  
end
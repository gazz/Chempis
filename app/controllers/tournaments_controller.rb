class TournamentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  
  def index
    @upcoming_tournaments = Tournament.upcoming()
    @previous_tournaments = Tournament.previous()
    
    @users = User.all.map do |user|
      games = Game.find_by_player(user.id)
      {:id=> user.id, :name => user.name, :points => 55, :tournament_count => user.tournaments.count,
        :game_count => games.count, 
        :games_won => GamesCalculator::calc_wins(games, user), 
        :games_lost => GamesCalculator::calc_loses(games, user)}
    end
    
  end
  
  def show
    @tournament = Tournament.find(params[:id])
    @games = @tournament.games
  end
  
  def new
    @tournament = Tournament.new
  end
  
  def edit
    @tournament = Tournament.find(params[:id])
  end
  
  def create
    @tournament = Tournament.new(params[:tournament])
    if @tournament.save
      flash[:success] = 'Turnīrs izveidots'
      redirect_to :action => :index
    else
      render :new
    end
  end

  def update
    @tournament = Tournament.find(params[:id])
    if (@tournament.update_attributes(params[:tournament]))
      flash[:success] = 'Turnīrs saglabāts'
      redirect_to :action => :index
    else
      render :edit
    end
  end
  
  def destroy
    @tournament = Tournament.find(params[:id])
    if @tournament.delete
      flash[:success] = 'Turnīrs izdzēsts'
    else
      flash[:success] = 'Nevar izdzēst turnīru'
    end
    redirect_to :action => :index
  end  

  def join
    @tournament = Tournament.find(params[:id])
    @tournament.users << current_user
    redirect_to :action => :index
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = "Lietotājs jau ir reģistrējies šim turnīram"
    redirect_to :back
  end
  
  def participants
    @tournament = Tournament.find(params[:id])
    # find users that 
    @users = User.all
  end
  
  def add_playaz
    @tournament = Tournament.find(params[:id])
    # add users to tournament
    #params[:users].each do |user_id, value|
    #  @tournament.users << User.find(user_id) unless value == 0
    #end
    redirect_to :action => :index
  end
  
end

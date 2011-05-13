class GamesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  
  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new(:tournament => Tournament.find(params[:tournament_id]))
  end
  
  def edit
    @game = Game.find(params[:id])
  end
  
  def create
    @tournament = Tournament.find(params[:tournament_id])
    @game = @tournament.games.build(params[:game])
    if @game.save
      flash[:success] = 'Spēle pievienota'
      redirect_to tournament_path(@tournament)
    else
      render :new
    end
  end
  
  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:success] = "Spēle saglabāta"
      redirect_to tournament_path(@game.tournament)
    else
      render :back
    end  
  end
  
  def destroy
    @game = Game.find(params[:id])
    if @game.delete
      flash[:success] = 'Spēle izdzēsta'
    else
      flash[:success] = 'Nav iespējams izdzēst spēli'
    end
    redirect_to tournament_path(@game.tournament)
  end
  

end

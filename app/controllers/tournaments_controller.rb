class TournamentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :destroy]
  
  def index
    @tournaments = Tournament.all
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
  end
  
end

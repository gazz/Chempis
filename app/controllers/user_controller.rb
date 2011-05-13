class UserController < ApplicationController
  before_filter :authenticate_user!
  layout 'tournaments'
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if (@user.update_attributes(params[:user]))
      flash[:success] = 'user profile updated'
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
  end

end
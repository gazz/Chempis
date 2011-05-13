class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render '/user/show'
  rescue ActiveRecord::RecordNotFound:
      flash[:notice] = 'Lietotājs neeksistē'
      redirect_to root_path
  end
end
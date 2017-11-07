class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "Welcome to the ALPHA-BLOG #{@user.username}"
      redirect_to articles_path
    else
      # render new page again which will display errors
      render 'new'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
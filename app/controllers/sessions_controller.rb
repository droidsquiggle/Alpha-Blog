class SessionsController < ApplicationController
  
  # used for displaying login page
  def new
    
  end
  
  # create session and move user to logged in state
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    #if the user was found and the user.authenticate based on enetered password
    if user && user.authenticate(params[:session][:password])
      # we are saving user id into the session so the browsers cookies will handle this
      # this id will be used across sessions
      session[:user_id] = user.id
      
      # flash a success and redirect to the users page
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      # re render the login page, but since this is not a model backed form we wont have validation messages
      # add a message with flash
      flash.now[:danger] = "Username or Password were incorrect"
      render 'new'
    end
  end
  
  # stop session and move user to logged out state
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end
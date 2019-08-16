class SessionsController < ApplicationController
  
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      
      path = user.id == 1 ? dev_path : root_path
      redirect_to path, notice: 'Logged in succesfully.'
    else
      flash.now[:alert] = 'Name or password is invalid.'
      render 'new'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path, notice: 'Logged out succesfully.'
  end
end

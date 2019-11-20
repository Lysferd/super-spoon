class SessionsController < ApplicationController
  
  skip_before_action :authorize

  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      
      path = user.id == 1 ? dev_path : root_path
      redirect_to path, notice: 'Logou com sucesso.'
    else
      flash.now[:alert] = 'Nome e/ou senha inválidos.'
      render 'new'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path, notice: 'Deslogou com sucesso.'
  end
end

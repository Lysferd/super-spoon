class SessionsController < ApplicationController
  skip_before_action :authorize
  #authorize_resource :class => false

  def new
  end

  def create
    user = User.find_by_name(params[:name].upcase)
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      
      path = case user.role?
             when :dev then dev_path
             when :admin then root_path
             when :supervisor then records_path
             when :operator then root_path
             when :manager then residents_path
             when :resident then root_path
             end

      redirect_to path, notice: 'Logou com sucesso.'
    else
      redirect_to login_path, alert: 'Nome e/ou senha inválidos.'
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path, notice: 'Deslogou com sucesso.'
  end
end


class SessionsController < ApplicationController
  def new
    @titre = "S'identifier"
  end

  def create
    user = User.authenticate_safely(params[:session][:email],
    params[:session][:password])

    if user.nil?
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
  
  def set_current_position
    position = []
    position << 3.17
    position << 2.0
    session[:current_position] = position
    redirect_to '/hobbies'
  end

end

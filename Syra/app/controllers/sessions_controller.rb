class SessionsController < ApplicationController
  def new
    @titre = "S'identifier"
  end

  def create
    user = User.authenticate_safely(params[:session][:email],
    params[:session][:password])
    
    
    if user.nil?
      Rails.logger.info 'tessst'
      Rails.logger.info user
      Rails.logger.info 'Pas ok session_controller email/mdp invalide'
      flash.now[:error] = "Combinaison Email/Mot de passe invalide."
      @titre = "S'identifier"
      render 'new'
    else
      Rails.logger.info 'ok session_controller '
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end

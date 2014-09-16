
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
    elsif user.isBanned
      flash[:error] = "Ce compte est suspendu"
      redirect_to signin_path
    elsif !user.confirmcode.nil?
      flash[:info] = "Veuillez consulter vos mails pour ainsi valider votre compte"
      redirect_to signin_path
    else
      sign_in user
      set_last_sign_in(user)
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
  end
  
  def set_last_sign_in(user)
    user.update_attribute(:last_sign_in_at,Time.now)
  end

end

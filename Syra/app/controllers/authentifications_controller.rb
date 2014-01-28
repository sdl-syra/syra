class AuthentificationsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]

    # Try to find authentication first
    authentication = Authentification.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      # Authentication found, sign the user in.
      flash[:notice] = "Signed in successfully."
      data = request.env["omniauth.auth"].extra.raw_info
      email  = data.email 
      user = User.authenticate_facebook(email)
      sign_in user
      redirect_to user
    else
    # Authentication not found, thus a new user.
      user = User.new
      user.apply_omniauth(auth)
      if user.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in user
        redirect_to user
      else
        flash[:error] = "Error while creating a user account. Please try again."
        redirect_to root_url
      end
    end
  end

end

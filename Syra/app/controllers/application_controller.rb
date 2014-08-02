class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_notifs_per_user
  before_filter :set_search
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def require_login
    unless current_user
      redirect_to signin_path
    end
  end

  def set_search
    @q=Service.search(params[:q])
  end
  
  def set_notifs_per_user
    @notifsctrl = []
    if (current_user)
      @notifsctrl = Notification.where(user: User.find(current_user.id))
    end
  end
  
  def restrict_access_admin
    unless current_user && current_user.isAdmin?
      render :file => 'public/401.html', :status => 401, :layout => false
      return
    end
  end

end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_notifs_per_user
  before_action :set_nbunread_messages
  before_filter :set_search
  before_action :handle_banned
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def require_login
    unless current_user
      redirect_to root_path
    end
  end
  
  def handle_banned
    if current_user && current_user.isBanned
      sign_out
    end
  end

  def set_search
    @q=Service.search(params[:q])
  end
  
  def set_nbunread_messages
    @nbUnread = Message.where(recipient:current_user,is_checked:false).group(:conv_code).length if current_user
  end
  
  def set_notifs_per_user
    @nbNewNotifs = Notification.where(user: current_user, is_checked: false).length if current_user
  end
  
  def restrict_access_admin
    unless current_user && current_user.isAdmin?
      render :file => 'public/401.html', :status => 401, :layout => false
      return
    end
  end

end

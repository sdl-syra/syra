class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_notifs_per_user
  before_filter :set_search
  before_action :handle_banned
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def require_login
    unless current_user
      redirect_to signin_path
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
  
  def set_notifs_per_user
    @notifsctrl = []
    if current_user
      @nbNewNotifs = Notification.where(user: current_user, is_checked: false).count
      if @nbNewNotifs > 10
        @notifsHeader = Notification.where(user: current_user, is_checked: false).order(created_at: :desc)
      else
        @notifsHeader = Notification.where(user: current_user).order(created_at: :desc).limit(10)
      end
      @hashNotifs = {}
      notifs = Notification.where(user: current_user).order(created_at: :desc)
      datesNotifs = (notifs.map {|n| n.date}.uniq).sort_by {|d| d}.reverse
      datesNotifs.each do |d|
        @hashNotifs[d] = (notifs.select {|n| n.date == d}).sort_by {|n| n.created_at}.reverse
      end
    end
  end
  
  def restrict_access_admin
    unless current_user && current_user.isAdmin?
      render :file => 'public/401.html', :status => 401, :layout => false
      return
    end
  end

end

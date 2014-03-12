class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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

end

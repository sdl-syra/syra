class PagesController < ApplicationController
  before_action :restrict_access_admin, only: [:administrator]
  before_action :set_user, only: [:header_search]
  
  def accueil
    redirect_to current_user if signed_in?
  end
  
  def header_search
    @services = []
    @users = []
    unless params[:search][:field].empty?
      sq = Service.search({"title_or_description_cont"=>params[:search][:field]})
      @services = sq.result(distinct: true).order(:title)
      sp = User.search({"name_or_lastName_or_email_cont"=>params[:search][:field]})
      @users = sp.result(distinct: true).order(:lastName)
    end
    respond_to do |format|
      format.html { render 'pages/search' }
      format.json { head :no_content }
    end
  end
  
  def administrator
    @users = User.all
    @services = Service.all
    @unresolvedReports = Report.where(guilty:nil)
    @criminals = User.where(isBanned:true).order(updated_at: :desc).take(5)
  end
  
  private
  
  def set_user
    @user = current_user
  end
  
end

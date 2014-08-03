class PagesController < ApplicationController
  before_action :restrict_access_admin, only: [:administrator]
  
  def accueil
  end
  
  def administrator
    @users = User.all
    @services = Service.all
    @unresolvedReports = Report.where(guilty:nil)
    @criminals = User.where(isBanned:true).order(updated_at: :desc).take(5)
  end
end

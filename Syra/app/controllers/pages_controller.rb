class PagesController < ApplicationController
  before_action :restrict_access_admin, only: [:administrator]
  before_action :set_user, only: [:header_search]
  
  def accueil
    redirect_to current_user if signed_in?
    nbServicesDansCarousel = 12
    @lesServices = Service.where(isFinished: false).limit(nbServicesDansCarousel).order("RANDOM()")
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
    set_panel_users
    set_panel_hobbies
    set_panel_services
    set_panel_propositions
    set_panel_opinions
    set_panel_categories
    set_panel_HP
    set_panel_reports
    set_panel_blogs
  end
  
  private
  
  def set_user
    @user = current_user
  end
  
  def most_active_users
    users = User.all.sort_by{|u| u.propositions.select{|p| p.isPaid}.length}.reverse.take(5)
    map = Hash.new
    users.each {|u| map[u] = u.propositions.select{|p| p.isPaid}.length}
    return map
  end
  
  def most_realised_services
    services = Service.all.sort_by{|s| s.propositions.select{|p| p.isPaid}.length}.reverse.take(5)
    map = Hash.new
    services.each {|s| map[s] = s.propositions.select{|p| p.isPaid}.length}
    return map
  end
  
  def most_active_reporters
    users = User.all.select{|u| !u.reports.empty?}.sort_by{|u| u.reports.length}.reverse.take(5)
    map = Hash.new
    users.each {|u| map[u] = u.reports.select{|r| r.guilty}}
    return map
  end
  
  def set_panel_users
    @nbUsers = User.all.count
    @nbUsersBanned = User.where(isBanned:true).count
    @nbUsersConnected = User.where("last_sign_in_at > ?",Time.now-15.minutes).count
    @nbUsersPremium = User.where(isPremium:true).count
    @mapMostActiveUsers = most_active_users
  end
  
  def set_panel_hobbies
    @nbHobbies = Hobby.all.count
    @nbHobbiesUsed = Hobby.all.select{|h| !h.users.empty?}.length
    @mostActiveHobbies = Hobby.all.sort_by{|h| h.users.length}.reverse.take(5)
  end
  
  def set_panel_services
    @nbServices = Service.all.count
    @nbServicesActive = Service.where(isFinished:false).count
    @nbServicesFinished = Service.where(isFinished:true).count
    @mostActiveServices = Service.all.sort_by{|s| s.propositions.length}.reverse.take(5)
  end
  
  def set_panel_propositions
    @nbPropositions = Proposition.all.count
    @nbPropositionsRealised = Proposition.where(isPaid:true).count
    @nbPropositionsWaiting = Proposition.where(isAccepted:nil).count
    @nbPropositionsRefused = Proposition.where(isAccepted:false).count
    @mapMostRealisedServices = most_realised_services
  end
  
  def set_panel_opinions
    @nbOpinions = Opinion.all.count
    @nbPositiveOpinions = Opinion.where("note>2").count
    @nbNegativeOpinions = Opinion.where("note<4").count
    @greatestServices = Service.where("note is not null").order(:note).limit(5)
  end
  
  def set_panel_categories
    @nbCategories = Category.all.count
    @nbCategoriesUsed = Category.all.select{|c| !c.services.empty?}.length
    @mostActiveCategories = Category.all.sort_by{|c| c.services.length}.reverse.take(5)
  end
  
  def set_panel_HP
    @totalMoney = User.all.map{|u| u.money}.inject{|sum, n| sum + n}
    @mostExpensiveService = Service.all.sort{|s| s.price}.reverse.first.price
    @avgCostService = (Service.all.map{|s| s.price}.inject{|sum, n| sum + n}.to_f / Service.all.count).round(2)
    @lessExpensiveService = Service.all.sort{|s| s.price}.first.price
    @nbUsersWithNoFuckinMoney = User.where("money < 1").count
    @FuckingRichUsers = User.order(money: :desc).limit(5)
  end
  
  def set_panel_reports
    @nbReports = Report.all.count
    @nbReportsWaiting = Report.where(guilty:nil).count
    @nbReportsUsefull = Report.where(guilty:true).count
    @nbReportsUseless = Report.where(guilty:false).count
    @mapMostActiveReporters = most_active_reporters
  end
  
  def set_panel_blogs
    @nbArticles = Article.all.count
    @nbComments = Comment.all.count
  end
  
  
  
end

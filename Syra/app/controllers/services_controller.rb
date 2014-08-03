class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy, :resolveReports]
  before_action :set_suggestions_demandes, only: [:index]
  before_action :set_report, only: [:show]
  before_filter :redirect_signup, unless: :signed_in?, :only => [:new]
  skip_before_filter :verify_authenticity_token, :only => :set_geolocation
  before_action :restrict_access_admin, only: [:admin]
 
  # GET /services
  # GET /services.json
  def index
    if params[:commit] == 'rechercheA' then
      render js: "alert('Hello Rails');"
    end
    if params[:recherche_service]
      @q = Service.where(:isGiven => true).search(params[:q])
      
    else
      if params[:propose_service]
       @q = Service.where(:isGiven => false).search(params[:q])
      end
    end
    
    #@q = Service.search(params[:q])
    if params[:q].present?
      @services = @q.result(distinct: true).order('title').page params[:page]
      address = []
      @services.each do |service|
        address << Address.find(service.address_id)
      end 
      respond_to do |format|
        format.js
        format.html # index.html.erb
        format.json { render json: @services }
      end
    else
      @services = Service.all.page params[:page]
      address = []
      @services.each do |service|
        address << Address.find(service.address_id)
      end 
      @services.sort! { |a, b| b.address <=> a.address }
      respond_to do |format|
        format.js
        format.html # index.html.erb
        format.json { render json: @services }
      end
    end
    
    
  end
 
  def set_geolocation
    session[:location] = {:latitude => params[:latitude], :longitude => params[:longitude]}
    render :index
  end


  # GET /admin/services
  def admin
    @services = Service.all
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    puts service_params
    tmp = service_params[:address_label]
    if service_params[:address].nil?
      tmpx = 0
      tmpy = 0
      tmpr = "aucune"
      tmpv = "aucune"
    else
      tmpx = service_params[:address][:x]
      tmpy = service_params[:address][:y]
      tmpr = service_params[:address][:region]
      tmpv = service_params[:address][:ville]
    end
    @service = Service.new(service_params.except(:address_label, :address))
    if tmp != ""
      ad = Address.new
      ad.x = tmpx
      ad.label = tmp
      ad.y = tmpy
      ad.region = tmpr
      ad.ville = tmpv
      ad.save
      @service.address = ad
    end
    @service.user = current_user
    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render action: 'show', status: :created, location: @service }
        UsersHelper.create_activity(current_user, "a crée un nouveau service")
      else
        format.html { render action: 'new' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    puts service_params
    tmp = service_params[:address_label]
    if service_params[:address].nil?
      tmpx = 0
      tmpy = 0
      tmpr = "aucune"
      tmpv = "aucune"
    else
      tmpx = service_params[:address][:x]
      tmpy = service_params[:address][:y]
      tmpr = service_params[:address][:region]
      tmpv = service_params[:address][:ville]
    end
    if tmp != ""
      ad = Address.new
      ad.x = tmpx
      ad.label = tmp
      ad.y = tmpy
      ad.region = tmpr
      ad.ville = tmpv
      ad.save
      @service.address = ad
    end
    respond_to do |format|
      if @service.update(service_params.except(:address_label, :address))
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    if signed_in?
      lesPropositions = Proposition.where(service:@service)
      lesPropositions.each do |p|
        if @service.isGiven?
          if p.isAccepted != false and not p.isPaid?
            p.user.money = p.user.money + p.price
            p.user.save
          end
        else
          if p.isAccepted? and not p.isPaid?
            @service.user.money = @service.user.money + p.price
            @service.user.save
          end
        end
        if p.isPaid.nil?
          NotificationsHelper.create_notif(p.user,"Service '"+p.service.title+"' supprimé, proposition annulée","/","fa fa-exchange")
        end
        p.destroy
      end
      delete_reports(@service)
      @service.destroy
      respond_to do |format|
        format.html { redirect_to user_path(@service.user) }
        format.json { head :no_content }
      end
    else
      flash[:errorconnexion] = true
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end
  end


  def accepterProp
    prop = Proposition.find(params[:prop])
    if signed_in?
      if prop.isAccepted.nil? and prop.service.user == current_user
        if not prop.service.isGiven?
          if prop.service.user.money > prop.price
            prop.service.user.money = prop.service.user.money - prop.price
            prop.service.user.save
            prop.isAccepted = true
            prop.save
            UserMailer.send_code(prop.service.user,prop.service,prop).deliver
            UsersHelper.grant_xp(prop.service.user,75)
            UsersHelper.grant_xp(prop.user,75)
            NotificationsHelper.create_notif(prop.user,"Proposition acceptée pour '"+prop.service.title+"'",proposition_path(prop.id.to_s),"fa fa-exchange")
            flash[:success] = "Proposition acceptée, l'échange est prévu pour le "+prop.proposition.to_formatted_s(:day_month_year)
          else
            flash[:error] = "Impossible, votre solde("+prop.service.user.money.to_s()+"hp) est inférieur au prix de la proposition("+prop.price.to_s()+"hp)"
          end
        else
          prop.isAccepted = true
          prop.save
          UserMailer.send_code(prop.user,prop.service,prop).deliver
          UsersHelper.grant_xp(prop.service.user,75)
          UsersHelper.grant_xp(prop.user,75)
          NotificationsHelper.create_notif(prop.user,"Proposition acceptée pour '"+prop.service.title+"'",proposition_path(prop.id.to_s),"fa fa-exchange")
          flash[:success] = "Proposition acceptée, l'échange est prévu pour le "+prop.proposition.to_formatted_s(:day_month_year)
        end
      end
    else
      flash[:errorconnexion] = true
    end
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end

  def refuserProp
    prop = Proposition.find(params[:proposition][:id])
    if signed_in?
      if prop.isAccepted.nil? and prop.service.user == current_user
        prop.motifCancelled = params[:proposition][:motifCancelled]
        prop.isAccepted = false
        prop.isPaid = false
        prop.save
        if prop.service.isGiven?
          prop.user.money = prop.user.money + prop.price
          prop.user.save
        end
        NotificationsHelper.create_notif(prop.user,"Proposition refusée pour '"+prop.service.title+"'",proposition_path(prop.id.to_s),"fa fa-exchange")
        flash[:success] = "Proposition refusée pour le motif suivant : '"+ prop.motifCancelled+"'"
      end
    else
      flash[:errorconnexion] = true
    end
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end
  
  def nouvelleProp
    serv = Service.find(params[:service])
    if not serv.isFinished?
      if serv.user != current_user
        if signed_in?
          prop_precedente = Proposition.where(user: current_user, service:serv, isAccepted:nil)
          if prop_precedente.count()==0
            if serv.isGiven? 
              if current_user.money.to_i >= serv.price
                respond_to do |format|
                  format.html { redirect_to(new_proposition_path(:service => serv.id)) }
                  format.json { head :no_content }
                end
              else
                flash[:error] = "Action impossible, votre solde("+current_user.money.to_s()+"hp) est inférieur au prix du service("+serv.price.to_s()+"hp)"
                respond_to do |format|
                  format.html { redirect_to(:back) }
                  format.json { head :no_content }
                end
              end
            else
              respond_to do |format|
                format.html { redirect_to(new_proposition_path(:service => serv.id)) }
                format.json { head :no_content }
              end
            end
          else
            if prop_precedente.count()==1
              flash[:error] = "Action impossible, vous avez déjà une proposition en attente pour ce service"
            else
              flash[:error] = "Action impossible, vous avez déjà des propositions en attente pour ce service"
            end
            respond_to do |format|
              format.html { redirect_to(:back) }
              format.json { head :no_content }
            end
          end
        else
          flash[:errorconnexion] = true
          respond_to do |format|
            format.html { redirect_to(:back) }
            format.json { head :no_content }
          end
        end
      else
        flash[:error] = "Action impossible, vous ne pouvez pas faire de proposition pour l'un de vos services"
        respond_to do |format|
          format.html { redirect_to(:back) }
          format.json { head :no_content }
        end
      end
    else
      flash[:error] = "Action impossible, ce service est terminé"
      respond_to do |format|
        format.html { redirect_to(:back) }
        format.json { head :no_content }
      end
    end
  end
  
  
  def cloturer
    if signed_in?
      serv = Service.find(params[:id])
      lesPropositions = Proposition.where(:isAccepted => nil)
      lesPropositions.each do |prop|
        if prop.service.user == current_user
          prop.motifCancelled = "Service clôturé."
          prop.isAccepted = false
          prop.isPaid = false
          prop.save
          if prop.service.isGiven?
            prop.user.money = prop.user.money + prop.price
            prop.user.save
          end
          NotificationsHelper.create_notif(prop.user,"Proposition refusée pour '"+prop.service.title+"'",proposition_path(prop.id.to_s),"fa fa-exchange")
        end
      end
      serv.isFinished = true
      serv.save
      flash[:success] = "Le service a été clôturé"
    else
      flash[:errorconnexion] = true
    end
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end
  
  def resolveReports
    if current_user && current_user.isAdmin?
      delete_reports(@service)
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end
  
  def delete_reports(serv)
    reports = Report.where(service_id:serv.id)
    reports.destroy_all
  end
  
  def set_report
    @report = Report.new
    @alreadyReported = true
    if current_user
      @alreadyReported = Report.where(user_id:current_user.id,service_id:@service.id).length>0
    end
  end
  
  def set_suggestions_demandes
    @suggestionsDemandes = []
    if (current_user)
      cats = []
      servUser = []
      propsUser = Proposition.where(user: User.find(current_user.id))
      demandes = propsUser.joins(:service).where(services: {isGiven: false})
      demandes.each do |p|
        servUser << p.service
        cats << p.service.category.id unless cats.include?(p.service.category.id)
      end
      cats.each do |k|
        demandestmp = Service.where(category: Category.find(k), isGiven: false)
        demandesRegion = demandestmp.joins(:address).where(addresses: {region: current_user.address.region})
        @suggestionsDemandes += (demandesRegion - servUser)
      end
      @suggestionsDemandes = @suggestionsDemandes.sample(3)
    end
  end

 
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :price, :description, :disponibility, :isGiven, :isFinished, :address_label, :category_id, :user_id,address: [:x,:y,:region,:ville])
    end

end

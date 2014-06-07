class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_filter :redirect_signup, unless: :signed_in?, :only => [:new]
  skip_before_filter :verify_authenticity_token, :only => :set_geolocation
 
  # GET /services
  # GET /services.json
  def index
    if params[:recherche_service]
      @q = Service.where(:isGiven => true).search(params[:q])
      
    else
      if params[:propose_service]
       @q = Service.where(:isGiven => false).search(params[:q])
      end
    end
    
    #@q = Service.search(params[:q])
    if params[:q].present?
      @services = @q.result(distinct: true).order('title')
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
      @services = Service.all
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
    tmpx = service_params[:address][:x]
    tmpy = service_params[:address][:y]
    tmpr = service_params[:address][:region]
    tmpv = service_params[:address][:ville]
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
    tmpx = service_params[:address][:x]
    tmpy = service_params[:address][:y]
    tmpr = service_params[:address][:region]
    tmpv = service_params[:address][:ville]
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
    lesPropositions = Proposition.where(service:@service)
    userService = @service.user
    lesPropositions.each do |p|
      if @service.isGiven?
        if p.isAccepted != false and p.isPaid != true
          p.user.money = p.user.money + p.price
          p.user.save
        end
      else
        if p.isAccepted? and p.isPaid != true
          @service.user.money = @service.user.money + p.price
          @service.user.save
        end
      end
      if p.isPaid.nil?
        NotificationsHelper.create_notif(p.user,"Service '"+p.service.title+"' supprimé, proposition annulée",p.id.to_s)
      end
      p.destroy
    end
    @service.destroy
    respond_to do |format|
      format.html { redirect_to user_path(userService) }
      format.json { head :no_content }
    end
  end


  def accepterProp
    prop = Proposition.find(params[:prop])
    prop.isAccepted = true
    prop.save
    serviceProp = Service.find(prop.service)
    if not serviceProp.isGiven?
      serviceProp.user.money = serviceProp.user.money - prop.price
      serviceProp.user.save
      UserMailer.send_code(serviceProp.user,serviceProp,prop).deliver
    else
      UserMailer.send_code(prop.user,serviceProp,prop).deliver
    end
    NotificationsHelper.create_notif(prop.user,"Proposition acceptée pour '"+prop.service.title+"'",prop.id.to_s)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end

  def refuserProp
    prop = Proposition.find(params[:proposition][:id])
    prop.motifCancelled = params[:proposition][:motifCancelled]
    prop.isAccepted = false
    prop.isPaid = false
    prop.save
    serviceProp = Service.find(prop.service)
    if serviceProp.isGiven?
      prop.user.money = prop.user.money + prop.price
      prop.user.save
    end
    NotificationsHelper.create_notif(prop.user,"Proposition refusée pour '"+prop.service.title+"'",prop.id.to_s)
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :no_content }
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

 
    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :price, :description, :disponibility, :isGiven, :isFinished, :address_label, :category_id, :user_id,address: [:x,:y,:region,:ville])
    end

end

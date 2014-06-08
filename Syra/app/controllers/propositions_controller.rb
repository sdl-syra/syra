class PropositionsController < ApplicationController
  before_action :set_proposition, only: [:show, :edit, :update, :destroy]

  # GET /propositions
  # GET /propositions.json
  def index
    @propositions = Proposition.all
  end
  
  # GET /admin/propositions
  def admin
    @propositions = Proposition.all
  end

  # GET /propositions/1
  # GET /propositions/1.json
  def show
  end

  # GET /propositions/new
  def new
    @proposition = Proposition.new
  end

  # GET /propositions/1/edit
  def edit
  end

  # POST /propositions
  # POST /propositions.json
  def create
    @proposition = Proposition.new(proposition_params)
    @proposition.user = current_user
    
    respond_to do |format|
      if @proposition.save
        format.html { redirect_to @proposition, notice: 'Proposition was successfully created.' }
        format.json { render action: 'show', status: :created, location: @proposition }
        NotificationsHelper.create_notif(@proposition.service.user,"Une nouvelle proposition pour '"+@proposition.service.title+"'",proposition_path(@proposition.id.to_s))
        serviceProp = Service.find(@proposition.service)
        if serviceProp.isGiven?
          current_user.money = current_user.money - serviceProp.price
          current_user.save
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @proposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /propositions/1
  # PATCH/PUT /propositions/1.json
  def update
    respond_to do |format|
      if @proposition.update(proposition_params)
        format.html { redirect_to @proposition, notice: 'Proposition was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /propositions/1
  # DELETE /propositions/1.json
  def destroy
    if @proposition.isAccepted.nil? and @proposition.user == current_user
      if @proposition.service.isGiven? and not @proposition.isPaid?
        @proposition.user.money = @proposition.user.money + @proposition.price
        @proposition.user.save
      end
      if @proposition.isPaid.nil?
          NotificationsHelper.create_notif(@proposition.service.user,"Proposition pour le service '"+@proposition.service.title+"' supprimée",proposition_path(@proposition.id.to_s))
        end
      @proposition.destroy
      flash[:success] = "Proposition supprimée avec succès"
      respond_to do |format|
        format.html { redirect_to service_path(@proposition.service) }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end
  end
  
  def validerEchange
    prop = Proposition.find(params[:id])
    codeUtilisateur = params[:proposition][:code]
    if signed_in?
      if prop.service.isGiven? and prop.service.user == current_user
        if codeUtilisateur == prop.code
          prop.isPaid = true
          prop.save
          prop.service.user.money = prop.service.user.money + prop.price
          prop.service.user.save
          NotificationsHelper.create_notif(@proposition.user,"Echange concernant le service '"+@proposition.service.title+"' validé",proposition_path(@proposition.id.to_s))
          flash[:success] = "Le code saisi est correct. La transaction est désormais complète. Merci d'avoir utilisé Syra !"
        else
          flash[:error] = "Le code saisi n'est pas correct, veuillez réessayer"
        end
      elsif not prop.service.isGiven? and prop.user == current_user
        if codeUtilisateur == prop.code
          prop.isPaid = true
          prop.save
          prop.user.money = prop.user.money + prop.price
          prop.user.save
          NotificationsHelper.create_notif(@proposition.service.user,"Echange concernant le service '"+@proposition.service.title+"' validé",proposition_path(@proposition.id.to_s))
          flash[:success] = "Le code saisi est correct. La transaction est désormais complète. Merci d'avoir utilisé Syra !"
        else
          flash[:error] = "Le code saisi n'est pas correct, veuillez réessayer"
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_proposition
      @proposition = Proposition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def proposition_params
      params.require(:proposition).permit(:isPaid, :isAccepted, :motifCancelled, :proposition, :comment, :user_id, :service_id, :price)
    end
end

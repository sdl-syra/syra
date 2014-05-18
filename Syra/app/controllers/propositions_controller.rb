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
        
        notification = Notification.new
        notification.user = @proposition.service.user
        notification.label = "Nouvelle proposition pour '"+@proposition.service.title+"'"
        notification.is_checked = false
        notification.date = Date.today
        notification.url = "propositions/"+@proposition.id.to_s
        notification.save
        
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
    @proposition.destroy
    respond_to do |format|
      format.html { redirect_to propositions_url }
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
      params.require(:proposition).permit(:isPaid, :isAccepted, :motifCancelled, :proposition, :comment, :user_id, :service_id)
    end
end

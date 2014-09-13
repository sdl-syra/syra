class OpinionsController < ApplicationController
  before_action :set_opinion, only: [:show, :edit, :update, :destroy]

  # GET /opinions
  # GET /opinions.json
  def index
    @opinions = Opinion.all
  end

  # GET /opinions/1
  # GET /opinions/1.json
  def show

  end

  # GET /opinions/new
  def new
    @opinion = Opinion.new
  end

  # GET /opinions/1/edit
  def edit
  end

  # POST /opinions
  # POST /opinions.json
  def create
    @opinion = Opinion.new(opinion_params)
    opinions = Opinion.where(service_id:@opinion.service.id)
    @opinion.service.update_attribute(:note,get_moyenne(opinions << @opinion))
    respond_to do |format|
      if @opinion.save
       flash[:avisSuccess] = "Votre avis est bien enregistré !"
        format.html {redirect_to :back}
        format.json { render action: 'show', status: :created, location: @opinion }
      else
        format.html { render action: 'new' }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opinions/1
  # PATCH/PUT /opinions/1.json
  def update
    respond_to do |format|
      if @opinion.update(opinion_params)
        flash[:avisSuccess] = "Votre avis est bien enregistré !"
        format.html :back
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opinions/1
  # DELETE /opinions/1.json
  def destroy
    @opinion.destroy
    respond_to do |format|
      format.html { redirect_to opinions_url }
      format.json { head :no_content }
    end
  end

  private
  
    def get_moyenne(opinions)
      notes = opinions.select{|o| o.note}
      return notes.inject { |sum, n| sum + n }.to_f / opinions.size
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_opinion
      @opinion = Opinion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opinion_params
      params.require(:opinion).permit(:avis, :note, :service_id, :user_id)
    end
end

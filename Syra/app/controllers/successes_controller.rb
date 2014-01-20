class SuccessesController < ApplicationController
  before_action :set_success, only: [:show, :edit, :update, :destroy]

  # GET /successes
  # GET /successes.json
  def index
    @successes = Success.all
  end

  # GET /successes/1
  # GET /successes/1.json
  def show
  end

  # GET /successes/new
  def new
    @success = Success.new
  end

  # GET /successes/1/edit
  def edit
  end

  # POST /successes
  # POST /successes.json
  def create
    @success = Success.new(success_params)

    respond_to do |format|
      if @success.save
        format.html { redirect_to @success, notice: 'Success was successfully created.' }
        format.json { render action: 'show', status: :created, location: @success }
      else
        format.html { render action: 'new' }
        format.json { render json: @success.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /successes/1
  # PATCH/PUT /successes/1.json
  def update
    respond_to do |format|
      if @success.update(success_params)
        format.html { redirect_to @success, notice: 'Success was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @success.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /successes/1
  # DELETE /successes/1.json
  def destroy
    @success.destroy
    respond_to do |format|
      format.html { redirect_to successes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_success
      @success = Success.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def success_params
      params.require(:success).permit(:label, :urlImageValidate, :urlImageUnvalidate, :locked, :user_id)
    end
end

class TreadsController < ApplicationController
  before_action :set_tread, only: [:show, :edit, :update, :destroy]

  # GET /treads
  # GET /treads.json
  def index
    @treads = Tread.all
  end

  # GET /treads/1
  # GET /treads/1.json
  def show
  end

  # GET /treads/new
  def new
    @tread = Tread.new
  end

  # GET /treads/1/edit
  def edit
  end

  # POST /treads
  # POST /treads.json
  def create
    @tread = Tread.new(tread_params)
    @tread.user = current_user
    respond_to do |format|
      if @tread.save
        format.html { redirect_to :back }
        format.json { render action: 'show', status: :created, location: @tread }
      else
        format.html { render action: 'new' }
        format.json { render json: @tread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treads/1
  # PATCH/PUT /treads/1.json
  def update
    respond_to do |format|
      if @tread.update(tread_params)
        format.html { redirect_to @tread, notice: 'Tread was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treads/1
  # DELETE /treads/1.json
  def destroy
    @tread.destroy
    respond_to do |format|
      format.html { redirect_to treads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tread
      @tread = Tread.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tread_params
      params.require(:tread).permit(:subject, :user_id, :hobby_id)
    end
end

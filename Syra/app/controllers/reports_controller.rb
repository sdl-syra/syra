class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy, :judge]

  # GET /reports
  # GET /reports.json
  def index
    reports = Report.where(guilty:nil).order(:created_at)
    reports.concat(Report.where.not(guilty:nil).order(created_at: :desc))
    services = reports.map {|r| r.service}.uniq
    @unsolvedCases, @criminalCases, @innocentCases = {}, {}, {}
    services.each do |s|
       reps = reports.select{|r| r.service==s}
       if reps.one?{|r| r.guilty?}
         @criminalCases[s] = reps
       elsif reps.none?{|r| r.guilty.nil?}
         @innocentCases[s] = reps
       else
         @unsolvedCases[s] = reps
       end
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        flash[:reported] = "Votre signalement est enregistré et sera analysé par un administrateur."
        format.html { redirect_to :back }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end
  
  def judge
    if (current_user.isAdmin?)
      unless (params[:guilty].nil?)
        @report.guilty = params[:guilty]=="yes"
        @report.save
      end
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:category, :content, :service_id, :user_id, :judge)
    end
end

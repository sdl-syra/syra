class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = Notification.all
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
  end

  # GET /notifications/new
  def new
    @notification = Notification.new
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @notification }
      else
        format.html { render action: 'new' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
  def deleteall
    Notification.where(user: User.find(current_user.id)).each do |n|
      n.destroy
    end
    respond_to do |format|
     format.html { redirect_to root_url }
     format.json { head :no_content }
    end
  end
  
  def checkedall
    Notification.where(user: User.find(current_user.id),is_checked: false).each do |n|
      n.is_checked=true;
      n.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def notification_params
      params.require(:notification).permit(:id, :user, :label, :glyph_cat, :object_id, :date, :is_checked)
    end
end

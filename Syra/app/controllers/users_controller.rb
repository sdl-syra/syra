class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_address, :upload_avatar, :update_hobbies, :unlock_badge]
  before_action :redirect_signup, unless: :signed_in?, except: [:new,:create]
  before_action :restrict_access_admin, only: [:admin]
  # GET /users
  # GET /users.json
  def index
    @q = User.search(params[:q])
    if params[:q].present?
      @users = @q.result(distinct: true)
    end
  end

  # GET /users
  # GET /users.json
  def admin
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @message = Message.new
    if (!params[:get].present? || params[:get]=="profil")
      @badges = Badge.all
      @userBadges = []
      @userBadges += @user.badges
      @hobby = Hobby.new
      @hobbies = Hobby.all
      @percentXP = UsersHelper.getPercent(@user.level.XPUser)
    end
    if (params[:get].present? && params[:get]=="echanges")
      @offered = Service.where(user:@user,isGiven:true).order(created_at: :desc, isFinished: :asc)
      @offeredUnfinished = Service.where(user:@user,isGiven:true,isFinished:false).count
      @asked = Service.where(user:@user,isGiven:false).order(created_at: :desc, isFinished: :asc)
      @askedUnfinished = Service.where(user:@user,isGiven:false,isFinished:false).count
      @propositions = Proposition.where("user_id = ? AND (isPaid is NULL OR isPaid = ?)", @user.id, false).order(created_at: :desc)
      @propositions = @propositions.select { |p| !p.service.isFinished?}
      @historique = Proposition.where(user:@user, isPaid:true).order(created_at: :desc)
    end
  end

  # GET /users/new
  def new
    @user = User.new
    if signed_in?
     respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
    end
  end

  # GET /users/1/edit
  def edit
  end

  def followers
    @user=current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.assign_attributes(address:Address.new, level:Level.new(levelUser:1, XPUser:0),
    isPremium:false, isBanned:false, confirmcode:UsersHelper.generate_code)
    respond_to do |format|
      if @user.save
        BadgesHelper.tryUnlockLvls(@user)
        UserMailer.registration_confirmation(@user).deliver
        UserMailer.send_code_confirmation(@user).deliver
        flash[:info] = "Veuillez consulter vos mails pour ainsi valider votre compte"
        format.html { redirect_to '/signin', notice: 'User was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def unlock_user
    @newuser = User.where(confirmcode:params[:id]).first
    unless @newuser.nil?
      @newuser.update_attribute(:confirmcode, nil)
      flash[:info] = "Votre compte est désormais activé !"
    end
    redirect_to signin_path
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
      format.js
    end
  end

  def update_address
    @user.address.update_attribute(:label,params[:user][:address]) if params[:id]==current_user.id.to_s
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
      format.js
    end
  end

  def upload_avatar
    if !params[:user].nil? && params[:id]==current_user.id.to_s
      uploaded_io = params[:user][:avatar]
      File.open(Rails.root.join('app', 'assets','images/avatars', @user.id.to_s+'avatar.png'), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @user.update_attribute(:avatar,@user.id.to_s+'avatar.png')
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # GET /users/follow
  def follow
    @user = current_user
    @user.follow!(params[:user])

    BadgesHelper.tryUnlock(Badge.find(6),current_user)

    userSuivi = User.find(params[:user])
    username = userSuivi.name + ' ' + userSuivi.lastName

    UsersHelper.create_activity(current_user, "suit désormais <a href=/users/" + userSuivi.id.to_s + ">" + userSuivi.name + " " + userSuivi.lastName + " </a>" )
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def favor
    @user = current_user
    @user.favor!(params[:user])

    userSuivi = User.find(params[:user])
    username = userSuivi.name + ' ' + userSuivi.lastName

    UsersHelper.create_activity(current_user, "a <a href=/users/" + userSuivi.id.to_s + ">" + userSuivi.name + " " + userSuivi.lastName + " </a> en favoris" )
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def unlock_badge
    if current_user.isAdmin? && params[:user].present? && params[:user][:badge].present?
      BadgesHelper.tryUnlock(Badge.find(params[:user][:badge].to_i),@user)
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # GET /users/unfollow
  def unfollow
    @user = current_user
    @user.unfollow!(params[:user])

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def criminals
    @criminals = User.where(isBanned:true).order(updated_at: :desc)
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def update_hobbies
    if params[:id]==current_user.id.to_s
      @user.hobbies.delete_all
      params[:user][:hobby_ids].delete_if{|i| i.empty?}
      @user.hobbies = Hobby.find(params[:user][:hobby_ids])
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :lastName, :email, :money, :password, :biography, :address, :isPremium, :isBanned, :banReason, :level_id, :success_id, :address_id, :email_confirmation, :password_confirmation, :phone,:q, :accept_conditions , :birthday)
  end

end

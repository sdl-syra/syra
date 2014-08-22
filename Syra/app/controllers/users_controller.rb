class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_address, :upload_avatar, :unlock_badge]
  before_filter :redirect_signup, unless: :signed_in?, :only => [:index]
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
    if (!params[:get].present? || params[:get]=="profil")
      @badges = Badge.all
      @userBadges = []
      @userBadges += @user.badges
      @hobby = Hobby.new
      @hobbies = Hobby.all
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
  end

  # GET /users/1/edit
  def edit
  end

  def followers
    @user=current_user
    if not signed_in?
      redirect_to '/signup'  
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.address = Address.new
    @user.level = Level.new
    @user.level.levelUser = 1
    @user.level.XPUser = 0
    @user.isPremium = false
    @user.isBanned = false
    respond_to do |format|
      if @user.save
        sign_in @user
          
        UserMailer.registration_confirmation(@user).deliver
        #UserMailer.welcome_email(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        @titre = "Sign up"
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
    if current_user && params[:id]==current_user.id.to_s
      @user.address.label = params[:user][:address]
      @user.address.save
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
      format.js
    end
  end

  def upload_avatar
    if (not params[:user].nil? && current_user && params[:id]==current_user.id.to_s)
      uploaded_io = params[:user][:avatar]
      File.open(Rails.root.join('app', 'assets','images/avatars', @user.id.to_s+'avatar.png'), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      @user.avatar = @user.id.to_s+'avatar.png'
      @user.save
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
    end
  end
  
  def unlock_badge
    if current_user && current_user.isAdmin? && params[:user].present? && params[:user][:badge].present?
      BadgesHelper.tryUnlock(Badge.find(params[:user][:badge].to_i),@user)
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
    
    BadgesHelper.tryUnlock(Badge.find(6),current_user) if current_user
    
    userSuivi = User.find(params[:user])
     username = userSuivi.name + ' ' + userSuivi.lastName

    UsersHelper.create_activity(current_user, "suit désormais <a href=/users/" + userSuivi.id.to_s + ">" + userSuivi.name + " " + userSuivi.lastName + " </a>" )
    respond_to do |format|
      format.html { redirect_to :back }
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :lastName, :email, :money, :password, :biography, :address, :isPremium, :isBanned, :banReason, :badge, :level_id, :success_id, :address_id, :email_confirmation, :password_confirmation, :phone,:q, :accept_conditions , :birthday)
  end

end

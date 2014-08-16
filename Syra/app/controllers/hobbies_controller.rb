class HobbiesController < ApplicationController
  before_action :set_hobby, only: [:show, :edit, :update, :destroy, :toggle_inscription]

  # GET /hobbies
  # GET /hobbies.json
  def index
    @hobbies = Hobby.all
  end

  # GET /hobbies/1
  # GET /hobbies/1.json
  def show
    @tread = Tread.new
    @reply = Reply.new
    @treads = Tread.where(hobby:@hobby).order(updated_at: :desc)
    @canReply = current_user && current_user.hobbies.include?(@hobby)
  end

  # GET /hobbies/new
  def new
    @hobby = Hobby.new
  end

  # GET /hobbies/1/edit
  def edit
  end

  # POST /hobbies
  # POST /hobbies.json
  def create
    @hobby = Hobby.new(hobby_params)

    respond_to do |format|
      if @hobby.save
        format.html { redirect_to @hobby, notice: 'Hobby was successfully created.' }
        format.json { render action: 'show', status: :created, location: @hobby }
      else
        format.html { render action: 'new' }
        format.json { render json: @hobby.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hobbies/1
  # PATCH/PUT /hobbies/1.json
  def update
    respond_to do |format|
      if @hobby.update(hobby_params)
        format.html { redirect_to @hobby, notice: 'Hobby was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hobby.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def toggle_inscription
    if current_user
      if current_user.hobbies.include?(@hobby)
        current_user.hobbies.delete(@hobby)
      else
        current_user.hobbies << @hobby  
      end
    end
    respond_to do |format|
      format.html { redirect_to @hobby, notice: 'Hobby was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # DELETE /hobbies/1
  # DELETE /hobbies/1.json
  def destroy
    @hobby.destroy
    respond_to do |format|
      format.html { redirect_to hobbies_url }
      format.json { head :no_content }
    end
  end

  def update_hobbies
    if current_user && params[:id]==current_user.id.to_s && (params[:hobby][:label] =~ /^\s*$/).nil?
      @user = current_user
      searched = params[:hobby][:label].titleize
      hobby = Hobby.where(label: searched)
      if hobby.empty?
        newHobby = Hobby.new
        newHobby.label = searched
        newHobby.save
        @user.hobbies << newHobby
      else
        @user.hobbies += hobby if !@user.hobbies.include?(hobby)
      end
    end
    respond_to do |format|
      format.html { redirect_to @user, notice: 'User was successfully updated.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hobby
      @hobby = Hobby.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hobby_params
      params.require(:hobby).permit(:label)
    end
end

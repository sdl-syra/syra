class RepliesController < ApplicationController
  before_action :set_reply, only: [:show, :edit, :update, :destroy]

  # GET /replies
  # GET /replies.json
  def index
    @replies = Reply.all
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
  end

  # GET /replies/new
  def new
    @reply = Reply.new
  end

  # GET /replies/1/edit
  def edit
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(reply_params)
    @reply.user = current_user
    respond_to do |format|
      if @reply.save
        @reply.tread.updated_at = @reply.created_at
        @reply.tread.save
        send_notifs_new_reply(@reply)
        format.html { redirect_to :back }
        format.json { render action: 'show', status: :created, location: @reply }
      else
        format.html { render action: 'new' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /replies/1
  # PATCH/PUT /replies/1.json
  def update
    respond_to do |format|
      if @reply.update(reply_params)
        format.html { redirect_to @reply, notice: 'Reply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replies/1
  # DELETE /replies/1.json
  def destroy
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to replies_url }
      format.json { head :no_content }
    end
  end

  private
    
    def send_notifs_new_reply(reply)
      users = reply.tread.replies.map {|r| r.user}.uniq
      users << reply.tread.user
      users.delete(reply.user)
      users.each do |u|
        NotificationsHelper.create_notif(u,"Une nouvelle réponse pour '"+reply.tread.hobby.label+" - "+reply.tread.subject[0..20]+"...'",
        hobby_path(reply.tread.hobby.id.to_s)+"#"+reply.tread.id.to_s,"fa fa-comments-o")
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reply_params
      params.require(:reply).permit(:content, :user_id, :tread_id)
    end
end

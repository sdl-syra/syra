class MessagesController < ApplicationController
  
  def all_conversations
    @conversations = Message.where("messages.sender_id =? OR messages.recipient_id =?",current_user.id,current_user.id)
    .group("sender_id,recipient_id").having("MAX(created_at)").order(created_at: :desc)
    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
  
  def show_conversation
    @conversation = Message.where("messages.sender_id =? OR messages.recipient_id =?",current_user.id,current_user.id).order(created_at: :desc)
  end
  
  def create
    params[:message][:sender_id]=current_user
    @message=Message.new(message_params)
    @message.is_checked=false
    respond_to do |format|
      if @message.save
        format.js
        format.html { redirect_to :back }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { render action: 'new' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
  
  def service_params
      params.require(:message).permit(:sender_id,:recipient_id,:content)
  end
end

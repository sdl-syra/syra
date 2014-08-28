class MessagesController < ApplicationController
  
  def all_conversations
    @conversations = Message.where("messages.sender_id =? OR messages.recipient_id =?",current_user.id,current_user.id)
    .group("conv_code").having("MAX(created_at)").order(created_at: :desc)
    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
  
  def show_conversation
    @conversation = seek_conversation(params[:id])
    @conversation.where(recipient:current_user,is_checked:false).update_all(is_checked:true)
    @message = Message.new
    @recipient = find_recipient(params[:id])
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def create
    params[:message][:conv_code] = conversation_id(current_user,User.find_by_id(params[:message][:recipient_id]))
    @message = Message.new(message_params)
    @message.is_checked = false
    @message.sender = current_user
    @message.save
    params[:id] = params[:message][:conv_code]
    show_conversation
  end
  
  private
  
  def seek_conversation(id)
    m = Message.where(conv_code:id).order(:created_at)
    m = Message.where(conv_code:swap(id)).order(:created_at) if m.empty?
    return m
  end
  
  def find_recipient(code)
    user = User.find_by_id(code.split("w")[1])
    user = User.find_by_id(code.split("w")[0]) if user == current_user
    return user
  end
  
  def swap(ch)
    return ch.split("w")[1]+"w"+ch.split("w")[0]
  end
  
  def conversation_id(user1,user2)
    randomMsg = Message.where("messages.conv_code=? OR messages.conv_code=?",user1.id.to_s+"w"+user2.id.to_s,user2.id.to_s+"w"+user1.id.to_s).limit(1)
    return randomMsg.empty? ? user1.id.to_s+"w"+user2.id.to_s : randomMsg[0].conv_code
  end
  
  def message_params
      params.require(:message).permit(:recipient_id,:conv_code,:content)
  end
end

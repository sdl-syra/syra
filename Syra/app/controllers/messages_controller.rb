class MessagesController < ApplicationController
  
  def all_conversations
    @conversations = Message.where("conv_code like ? or conv_code like ?","%w"+current_user.id.to_s,current_user.id.to_s+"w%").
    group(:conv_code).having("max(created_at)").order(created_at: :desc).page(params[:page]).per(5)
    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
  
  def show_conversation
    conv = seek_conversation(params[:id])
    conv.where(recipient:current_user,is_checked:false).update_all(is_checked:true)
    @conversation = conv.page params[:page]
    @nb_pages = @conversation.total_pages
    @conversation = @conversation.reverse
    @message = Message.new
    @recipient = find_recipient(params[:id])
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def more_msgs
    conv = seek_conversation(params[:id])
    conv.where(recipient:current_user,is_checked:false).update_all(is_checked:true)
    @conversation = conv.page params[:page]
    @current_page = params[:page]
    @num_pages = @conversation.num_pages
    @conversation = @conversation.reverse
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
    m = Message.where(conv_code:id).order(created_at: :desc)
    m = Message.where(conv_code:swap(id)).order(created_at: :desc) if m.empty?
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

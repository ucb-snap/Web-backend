class MessageController < ApplicationController
  def conversations
    @conversations = current_user.conversations.includes(:users)
  end

  def messages
    @conversation = Conversation.find(params[:conversation_id])
    @messages = @conversation.messages
  end

  def new_message
  end

  def create_new_message
    accounts = find_users_by_username(params[:message])
    redirect_to create_message_path and return unless accounts
    users = [current_user] + accounts
    @conversation = Conversation.new_or_exitsing_conversation(current_user, users)
    @conversation.add_users(accounts)
    @conversation.messages.create(message_params)
    redirect_to conversations_path
  end
  
  def reply
    @conversation = Conversation.find(params[:conversation_id])
    @conversation.messages.create(message_params)
    redirect_to messages_path
  end

  def destroy
    @conversation = Conversation.find(params[:conversation_id])
    @conversation.destroy
    flash[:notice] = "Conversation successfully deleted."
    redirect_to conversations_path
  end

  private

  def message_params
    {:user_id => current_user.id, :message_time => DateTime.now, :content => params[:message][:text]}
  end
end

class SnapuserController < ApplicationController
  def show
    id = params[:id]
    @user = Snapuser.find(id)
  end

  def index
    @users = Snapuser.all
  end

  def new
  end

  def create
    @user = Snapuser.create!(user_params)
    log_in @user
    flash[:notice] = "#{@user.username} was successfully created."
    redirect_to snapuser_index_path
  end

  def edit
    @user = Snapuser.find params[:id]
  end

  def update
    @user = Snapuser.find params[:id]
    @user.update_attributes!(user_params)
    @user.save!
    flash[:notice] = "#{@user.username} was successfully updated."
    redirect_to snapuser_path(@user)
  end

  def destroy
    @user = Snapuser.find(params[:id])
    @user.destroy
    flash[:notice] = "User '#{@user.username}' deleted."
    redirect_to snapuser_index_path
  end

  def projects
    @user = Snapuser.find(params[:id])
    if @user == current_snapuser
      @publicprojects = @user.snapprojects
    else
      @publicprojects = public_projects
    end
  end

  def conversations
    @conversations = current_snapuser.conversations

  end
  def messages
    @messages = Conversation.find(params[:conversation_id]).messages
    @conversation = Conversation.find(params[:conversation_id])
  end

  def new_message
  end

  def reply
    @conversation = Conversation.find(params[:conversation_id])
    messages_params = {:snapuser_id => current_snapuser.id, :message_time => DateTime.now, :content => params[:message][:text]}
    @conversation.messages.create(messages_params)
    redirect_to messages_path
  end

  def create_new_message
    users = params[:conversation][:recipients].split(", ")
    accounts = [current_snapuser]
    users.each do |user|
      accounts += [Snapuser.find_by_username(user)]
    end
    @conversation = nil
    @conversations = current_snapuser.conversations
    @conversations.each do |conversation|
      if conversation.check(accounts)
        @conversation = conversation
        break
      end
    end

    if not @conversation
      @conversation = current_snapuser.conversations.create(conversation_params)
      if not @conversation.valid?
        flash[:notice] = "Missing required fields"
        redirect_to new_messages_path and return
      end
    end
    users.each do |user|
      if not user
        flash[:notice] = "User #{user} does not exist"
        redirect_to new_snapproject_path and return
      else
        @temp_user = Snapuser.find_by_username(user)
        if not @temp_user.conversations.include?(@conversation)
          @temp_user.conversations << @conversation
        end
      end
    end
    ######
    messages_params = {:snapuser_id => current_snapuser.id, :message_time => DateTime.now, :content => params[:conversation][:text]}
    @conversation.messages.create(messages_params)
    @conversation.save
    redirect_to conversations_path
  end

  def destroy
    @conversation = Conversation.find(params[:conversation_id])
    @conversation.destroy
    flash[:notice] = "Conversation successfully deleted."
    redirect_to conversations_path
  end

  private
  def user_params
    params.require(:snapuser).permit(:username, :password, :email, :account_type)
  end


  private
  def conversation_params
    params.require(:conversation).permit(:username)
  end

  def public_projects
    @user.snapprojects.select{|project| project.privacy=='Public'}
  end

end

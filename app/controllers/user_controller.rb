class UserController < ApplicationController
  def show
    id = params[:id]
    @user = User.find(id)
  end

  def index
    @users = User.all
  end

  def new
  end

  def create
    @user = User.create!(user_params)
    log_in @user
    flash[:notice] = "#{@user.username} was successfully created."
    redirect_to user_index_path
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes!(user_params)
    @user.save!
    flash[:notice] = "#{@user.username} was successfully updated."
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "User '#{@user.username}' deleted."
    redirect_to user_index_path
  end

  # a user can view all his courses
  def taught
    @user = User.find(params[:id])
    if @user == current_user
      @courses = @user.taught_courses
    else
      @courses = public_taught_courses
    end
    render 'view_courses'
  end

  def enrolled
    @user = User.find(params[:id])
    if @user == current_user
      @courses = @user.enrolled_courses
    else
      @courses = public_enrolled_courses
    end
    render 'view_courses'
  end

  def all_courses
    @user = User.find(params[:id])
    if @user == current_user
      @courses = @user.all_courses
    else
      @courses = public_all_courses
    end
    render 'view_courses'
  end

  def projects
    @user = User.find(params[:id])
    if @user == current_user
      @publicprojects = @user.projects
    else
      @publicprojects = public_projects
    end
  end

  def conversations
    @conversations = current_user.conversations

  end
  def messages
    @messages = Conversation.find(params[:conversation_id]).messages
    @conversation = Conversation.find(params[:conversation_id])
  end

  def new_message
  end

  def reply
    @conversation = Conversation.find(params[:conversation_id])
    messages_params = {:user_id => current_user.id, :message_time => DateTime.now, :content => params[:message][:text]}
    @conversation.messages.create(messages_params)
    redirect_to messages_path
  end

  def create_new_message
    users = params[:conversation][:recipients].split(", ")
    accounts = [current_user]
    users.each do |user|
      accounts += [User.find_by_username(user)]
    end
    @conversation = nil
    @conversations = current_user.conversations
    @conversations.each do |conversation|
      if conversation.check(accounts)
        @conversation = conversation
        break
      end
    end

    if not @conversation
      @conversation = current_user.conversations.create(conversation_params)
      if not @conversation.valid?
        flash[:notice] = "Missing required fields"
        redirect_to new_messages_path and return
      end
    end
    users.each do |user|
      if not user
        flash[:notice] = "User #{user} does not exist"
        redirect_to new_messages_path and return
      else
        @temp_user = User.find_by_username(user)
        if not @temp_user.conversations.include?(@conversation)
          @temp_user.conversations << @conversation
        end
      end
    end
    ######
    messages_params = {:user_id => current_user.id, :message_time => DateTime.now, :content => params[:conversation][:text]}
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
    params.require(:user).permit(:username, :password, :email, :account_type)
  end


  private
  def conversation_params
    params.require(:conversation).permit(:username)
  end

  def public_projects
    @user.projects.select{|project| project.privacy=='Public'}
  end

  def public_taught_courses
    @user.taught_courses.select{|course| course.privacy=='Public'}
  end

  def public_enrolled_courses
    @user.enrolled_courses.select{|course| course.privacy=='Public'}
  end

  def public_all_courses
    @user.taught_courses.select{|course| course.privacy=='Public'} + @user.enrolled_courses.select{|project| project.privacy=='Public'}
  end

end

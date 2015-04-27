class ProjectController < ApplicationController
  def show
    id = params[:id]
    @project = Project.find(id)
    @users = @project.users
    @comments = @project.comments.includes(:user)
  end

  def index
  end

  def new
  end

  def create
    @project = current_user.projects.create(project_params)
    unless @project.valid?
      @project.destroy
      flash[:alert] = "Missing required fields"
      redirect_to new_project_path and return
    else
      users = find_users
      unless users
        @project.destroy
        redirect_to new_project_path and return
      end
      User.add_project_to_users(users, @project)
      flash[:notice] = "'#{@project.name}' was successfully created."
      redirect_to project_path(@project)
    end
  end

  def edit
    @project = Project.find(params[:id])
    @users = @project.users.select{|user| user!=current_user}.map{|user| user.email}.join(", ")
  end

  def update
    @project = Project.find(params[:id])
    users = find_users
    redirect_to edit_project_path(@project) and return unless users
    @project.update_attributes(project_params)
    unless @project.valid?
      flash[:alert] = "Missing required fields"
      redirect_to edit_project_path(@project) and return
    else
      @project.save
      User.add_project_to_users([current_user] + users, @project)
      flash[:notice] = "'#{@project.name}' was successfully updated."
      redirect_to project_path(@project)
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Project '#{@project.name}' deleted."
    redirect_to user_projects_path(current_user)
  end

  def comment
    @project = Project.find(params[:id])
    Comment.create(comment_params)
    redirect_to project_path(@project)
  end

  private

  def project_params
    # Input: Paramters Hash (params)
    # Output: Hash containing the parameters for a new project

    params.require(:project).permit(:name, :description, :privacy)
  end

  def find_users
    # Input: Parameters Hash (params)
    # Output: If all additional owners are valid, then a list of those users
    #         If the additional owners are invalid, then returns False

    additional_users = params[:project][:additional_owners].split(/ |, |,/)
    additional_users = additional_users.select{ |email| email != current_user.email}
    valid = User.validate_emails(additional_users)
    unless valid[0]
      flash[:alert] = "No User(s) with the following emails are registered: " + valid[1]
      return false
    else
      valid[1]
    end
  end

  def comment_params
    # Input: Parameters Hash (params)
    # Output: Hash containing the parameters for a new comment

    parameters = {:user_id => current_user.id, :project_id => params[:id], :comment_time => DateTime.now,
      :content => params[:comment][:comment_content]}
  end
end

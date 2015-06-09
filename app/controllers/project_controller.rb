class ProjectController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @users = @project.users
    @comments = @project.comments.includes(:user)
  end

  def index
    @user = User.find(params[:id])
    @projects = (@user == current_user) ? @user.projects.includes(:users).select{|project| project.type==nil} : @user.public_projects
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
      users = find_users_by_email(params[:project])
      unless users
        @project.destroy
        redirect_to new_project_path and return
      end
      @project.add_users(users)
      flash[:notice] = "'#{@project.name}' was successfully created."
      redirect_to project_path(@project)
    end
  end

  def edit
    @project = Project.find(params[:id])
    @users = @project.users.select{ |user| user != current_user }.map{ |user| user.email }.join(", ")
  end

  def update
    @project = Project.find(params[:id])
    users = find_users_by_email(params[:project])
    redirect_to edit_project_path(@project) and return unless users
    @project.update_attributes(project_params)
    unless @project.valid?
      flash[:alert] = "Missing required fields"
      redirect_to edit_project_path(@project) and return
    else
      @project.save
      @project.add_users([current_user] + users)
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
    params.require(:project).permit(:name, :description, :privacy)
  end

  def comment_params
    parameters = {:user_id => current_user.id, :project_id => params[:id], :comment_time => DateTime.now,
      :content => params[:comment][:comment_content]}
  end
end

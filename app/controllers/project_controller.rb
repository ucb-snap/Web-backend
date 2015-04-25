class ProjectController < ApplicationController
  def show
    id = params[:id]
    @project = Project.find(id)
    @comments = @project.snapcomments
  end

  def index
  end

  def new
  end

  def create
    @user = current_user
    @project = current_user.projects.create(project_params)
    if not @project.valid?
      flash[:alert] = "Missing required fields"
      redirect_to new_project_path and return
    else
      additional_users = params[:project][:additional_owners].split(/ |, |,/)
      additional_users = additional_users.select{|email| email!=current_user.email}
      additional_users.each do |user|
        u = User.find_by_email(user)
        if not u
          flash[:notice] = "User #{user} does not exist"
          redirect_to new_project_path and return
        else
          u.projects << @project
        end
      end
      current_user.save
      flash[:notice] = "'#{@project.name}' was successfully created."
      redirect_to project_path(@project)
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    if not @project.valid?
      flash[:notice] = "Missing required fields"
      redirect_to edit_project_path(@project) and return
    else
      @project.save
      @project.users.each do |user|
        @project.users.delete(user)
      end
      current_user.projects << @project
      additional_users = params[:project][:additional_owners].split(/ |, |,/)
      additional_users = additional_users.select{|email| email!=current_user.email}
      additional_users.each do |user|
        u = User.find_by_email(user)
        if not u
          flash[:notice] = "User #{user} does not exist"
          redirect_to edit_project_path(@project) and return
        elsif !@project.users.include?(u)
           u.projects << @project
        end
      end
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
    Snapcomment.create(comment_params)
    redirect_to project_path(@project)
  end

  def comment_params
    parameters = {:user_id => current_user.id, :project_id => params[:id], :comment_time => DateTime.now,
      :content => params[:snapcomment][:comment_content]}
  end

  def project_params
    params.require(:project).permit(:name, :description, :privacy)
  end
end

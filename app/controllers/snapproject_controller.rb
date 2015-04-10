class SnapprojectController < ApplicationController
  def show
    id = params[:id]
    @project = Snapproject.find(id)
    @comments = @project.snapcomments
  end

  def index
    @projects = current_snapuser.snapprojects
  end

  def new
  end

  def create
    @user = current_snapuser
    @project = current_snapuser.snapprojects.create(project_params)
    if not @project.valid?
      flash[:notice] = "Missing required fields"
      redirect_to new_snapproject_path and return
    else
      additional_users = params[:snapproject][:additional_owners].split(/ |, |,/)
      additional_users.each do |user| 
        u = Snapuser.find_by_email(user)
        if u 
          u.snapprojects << @project
        elsif u==current_snapuser
          
        else
          flash[:notice] = "User #{user} does not exist"
          redirect_to new_snapproject_path and return
        end
      end
      current_snapuser.save
      flash[:notice] = "'#{@project.name}' was successfully created."
      redirect_to snapproject_path(@project)
    end
  end

  def edit
    @project = Snapproject.find(params[:id])
  end

  def update
    @project = Snapproject.find(params[:id])
    @project.update_attributes(project_params)
    if not @project.valid?
      flash[:notice] = "Missing required fields"
      redirect_to edit_snapproject_path(@project) and return
    else
      @project.save
      flash[:notice] = "'#{@project.name}' was successfully updated."
      redirect_to snapproject_path(@project)
    end
  end

  def destroy
    @project = Snapproject.find(params[:id])
    @project.destroy
    flash[:notice] = "Project '#{@project.name}' deleted."
    redirect_to snapproject_index_path
  end

  def comment
    @project = Snapproject.find(params[:id])
    Snapcomment.create(comment_params)
    redirect_to snapproject_path(@project)
  end

  def comment_params
    parameters = {:snapuser_id => current_snapuser.id, :snapproject_id => params[:id], :comment_time => DateTime.now, 
      :content => params[:snapcomment][:comment_content]}
  end

  def project_params
    params.require(:snapproject).permit(:name, :description, :privacy)
  end
end

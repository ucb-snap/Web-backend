class SnapprojectController < ApplicationController
  def show
    id = params[:id]
    @project = Snapproject.find(id)
  end

  def index
    @projects = Snapproject.find(current_snapuser.id)
  end

  def new
  end

  def create
    @project = Snapproject.create(params[:snapproject])
    #current_snapuser.Snapproject.create(params)
    current_snapuser.snapprojects << @project
    current_snapuser.save 
    #if params[:name].present?
    flash[:notice] = "'#{@project.name}' was successfully created."
    redirect_to snapproject_path(@project)
    #else
      #flash[:notice] = "Please enter a project name."
      #redirect_to new_snapproject_path
    #end
  end

  def edit
    @project = Snapproject.find(params[:id])
  end

  def update
    @project = Snapproject.find(params[:id])
    @project.update_attributes!(project_params)
    @project.save!
    flash[:notice] = "'#{@project.name}' was successfully updated."
    redirect_to snapproject_path(@project)
  end

  def destroy
    @project = Snapproject.find(params[:id])
    @project.destroy
    flash[:notice] = "Project '#{@project.name}' deleted."
    redirect_to snapproject_index_path
  end

  def project_params
    params.require(:snapproject).permit(:name, :description, :class, :privacy)
  end
end
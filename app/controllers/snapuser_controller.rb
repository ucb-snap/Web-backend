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

  private

  def user_params
    params.require(:snapuser).permit(:username, :password, :email, :account_type)
  end

  def public_projects
    @user.snapprojects.select{|project| project.privacy=='Public'}
  end

end

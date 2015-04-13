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

  # a user can view all his classes
  def taught
    @classes = Snapuser.find(params[:id]).taught_classes
    render 'view_classes'
  end

  def enrolled
    @classes = Snapuser.find(params[:id]).enrolled_classes
    render 'view_classes'
  end

  def all_classes
    @classes = Snapuser.find(params[:id]).all_classes
    render 'view_classes'
  end

  private

  def user_params
    params.require(:snapuser).permit(:username, :password, :email, :account_type)
  end

end

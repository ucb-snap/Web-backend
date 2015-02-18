class SessionsController < ApplicationController
  def new
  end

  def create
    user = Snapuser.find_by(username: params[:snapuser][:username])
    if user && params[:snapuser][:password] == user.password
      log_in user
      redirect_to snapuser_index_path
    else
      flash.now[:danger] = 'Invalid Username or Password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to snapuser_index_path
  end
end

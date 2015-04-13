class SnapclassController < ApplicationController
  def show
    @class = Snapclass.find(params[:id])
  end

  def index
  end

  def new

  end

  def create
    @user = current_snapuser
    @class = Snapclass.create(class_params)
    @user.taught_classes << @class
    flash[:notice] = "Class #{@class.title} successfully created"
    redirect_to snapuser_path(@user)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def class_params
    params.require(:snapclass).permit(:title, :description)
  end
end

class SnapclassController < ApplicationController
  def show
    id = params[:id]
    @class = Snapclass.find(id)
  end

  def index
    @classes = Snapclass.all
  end

  def new

  end

  def create
    @user = current_snapuser
    @class = Snapclass.create(class_params)
    flash[:notice] = "Class #{@class.title} successfully created"
    redirect_to snapuser_path(@user)
  end

  def edit
    @class = Snapclass.find(params[:id])
  end

  def update
    @class = Snapclass.find(params[:id])
    @class.update_attributes!(class_params)
    @user.save!
    flash[:notice] = "#{@class.title} was successfully updated."
    redirect_to snapclass_path(@class)
  end

  def destroy
    @class = Snapclass.find(params[:id])
    @class.destroy
    flash[:notice] = "Class '#{@class.title}' deleted."
    redirect_to snapclass_index_path
  end

  def class_params
    params.require(:snapclass).permit(:teacher_id, :title, :description, :privacy)
  end
end

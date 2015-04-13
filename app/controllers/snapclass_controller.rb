class SnapclassController < ApplicationController
  def show
    @class = Snapclass.find(params[:id])
  end

  def index
    @classes = Snapclass.all
  end

  def new

  end

  def create
    @user = current_snapuser
    @class = Snapclass.create(class_params)
    @user.taught_classes << @class
    additional_teacher = params[:snapclass][:additional_teachers].split(/ |, |,/)
    additional_teacher = additional_teacher.select{|email| email!=current_snapuser.email}
    additional_teacher.each do |teacher|
      user = Snapuser.find_by_email(teacher)
      if not user
        flash[:notice] = "User #{teacher} does not exist"
        redirect_to new_snapproject_path and return
      else
        user.taught_classes << @class
      end
    end
    flash[:notice] = "Class #{@class.title} successfully created"
    redirect_to snapuser_path(@user)
  end

  def edit
    @class = Snapclass.find(params[:id])
  end

  def update
    @class = Snapclass.find(params[:id])
    @class.update_attributes!(class_params)
    additional_teacher = params[:snapclass][:additional_teachers].split(/ |, |,/)
    additional_teacher = additional_teacher.select{|email| email!=current_snapuser.email}
    additional_teacher.each do |teacher|
      user = Snapuser.find_by_email(teacher)
      if not user
        flash[:notice] = "User #{teacher} does not exist"
        redirect_to new_snapproject_path and return
      elsif !@class.teachers.include?(user)
        user.taught_classes << @class
      end
    end
    @class.save!
    flash[:notice] = "#{@class.title} was successfully updated."
    redirect_to snapclass_path(@class)
  end

  def destroy
    @class = Snapclass.find(params[:id])
    @class.destroy
    flash[:notice] = "Class '#{@class.title}' deleted."
    redirect_to snapuser_path(current_snapuser)
  end

  def enroll
    @user = Snapuser.find(params[:student][:id])
    @class = Snapclass.find(params[:id])
    @class.students << @user
    flash[:notice] = "Successfully enrolled!"
    redirect_to snapclass_path(@class)
  end

  def unenroll
    @user = Snapuser.find(params[:student][:id])
    @class = Snapclass.find(params[:id])
    @class.students.delete(@user)
    flash[:notice] = "Successfully Unenrolled!"
    redirect_to snapclass_path(@class)
  end

  def class_params
    params.require(:snapclass).permit(:title, :description, :privacy)
  end
end

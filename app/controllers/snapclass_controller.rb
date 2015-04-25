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
    if not @class.valid?
      flash[:alert] = "Missing required fields"
      redirect_to new_snapclass_path and return
    else
      @user.taught_classes << @class
      additional_teacher = params[:snapclass][:additional_teachers].split(/ |, |,/)
      additional_teacher = additional_teacher.select{|email| email!=current_snapuser.email}
      additional_teacher.each do |teacher|
        user = Snapuser.find_by_email(teacher)
        if not user
          flash[:notice] = "User #{teacher} does not exist"
          redirect_to new_snapclass_path and return
        else
          user.taught_classes << @class
        end
      end
      flash[:notice] = "Class #{@class.title} successfully created"
      redirect_to snapclass_path(@class)
    end
  end

  def edit
    @class = Snapclass.find(params[:id])
  end

  def update
    @class = Snapclass.find(params[:id])
    @class.update_attributes!(class_params)
    if not @class.valid?
      flash[:notice] = "Missing required fields"
      redirect_to edit_snapclass_path(@class) and return
    else
      @class.save
      @class.teachers.each do |teacher|
        @class.teachers.delete(teacher)
      end
      current_snapuser.taught_classes << @class
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

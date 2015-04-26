class CourseController < ApplicationController
  def show
    @course = Course.find(params[:id])
  end

  def index
    @courses = Course.all
  end

  def new

  end

  def create
    @user = current_user
    @course = Course.create(course_params)
    if not @course.valid?
      flash[:alert] = "Missing required fields"
      redirect_to new_course_path and return
    else
      @user.taught_courses << @course
      additional_teacher = params[:course][:additional_teachers].split(/ |, |,/)
      additional_teacher = additional_teacher.select{|email| email!=current_user.email}
      additional_teacher.each do |teacher|
        user = User.find_by_email(teacher)
        if not user
          flash[:notice] = "User #{teacher} does not exist"
          redirect_to new_course_path and return
        else
          user.taught_courses << @course
        end
      end
      flash[:notice] = "Course #{@course.title} successfully created"
      redirect_to course_path(@course)
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update_attributes!(course_params)
    if not @course.valid?
      flash[:notice] = "Missing required fields"
      redirect_to edit_course_path(@course) and return
    else
      @course.save
      @course.teachers.each do |teacher|
        @course.teachers.delete(teacher)
      end
      current_user.taught_courses << @course
      additional_teacher = params[:course][:additional_teachers].split(/ |, |,/)
      additional_teacher = additional_teacher.select{|email| email!=current_user.email}
      additional_teacher.each do |teacher|
        user = User.find_by_email(teacher)
        if not user
          flash[:notice] = "User #{teacher} does not exist"
          redirect_to new_project_path and return
        elsif !@course.teachers.include?(user)
          user.taught_courses << @course
        end
      end
      @course.save!
      flash[:notice] = "#{@course.title} was successfully updated."
      redirect_to course_path(@course)
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Course '#{@course.title}' deleted."
    redirect_to user_path(current_user)
  end

  def enroll
    @user = User.find(params[:student][:id])
    @course = Course.find(params[:id])
    @course.students << @user
    flash[:notice] = "Successfully enrolled!"
    redirect_to course_path(@course)
  end

  def unenroll
    @user = User.find(params[:student][:id])
    @course = Course.find(params[:id])
    @course.students.delete(@user)
    flash[:notice] = "Successfully Unenrolled!"
    redirect_to course_path(@course)
  end

  def course_params
    params.require(:course).permit(:title, :description, :privacy)
  end
end

class CourseController < ApplicationController
  def show
    @course = Course.find(params[:id])
    @teachers = @course.teachers
    @students = @course.students
  end

  def new

  end

  def create
    @course = current_user.taught_courses.create(course_params)
    unless @course.valid?
      @course.destroy
      flash[:alert] = "Missing required fields"
      redirect_to new_course_path and return
    else
      users = find_users_by_email(params[:course])
      unless users
        @project.destroy
        redirect_to new_project_path and return
      end
      @course.add_teachers(users)
      flash[:notice] = "Course #{@course.title} successfully created"
      redirect_to course_path(@course)
    end
  end

  def edit
    @course = Course.find(params[:id])
    @teachers = @course.teachers.select{|user| user!=current_user}.map{|user| user.email}.join(", ")
  end

  def update
    @course = Course.find(params[:id])
    users = find_users_by_email(params[:course])
    redirect_to edit_course_path(@course) and return unless users
    @course.update_attributes(course_params)
    unless @course.valid?
      flash[:notice] = "Missing required fields"
      redirect_to edit_course_path(@course) and return
    else
      @course.save
      @course.add_teachers([current_user] + users)
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
    @course = Course.find(params[:id])
    @course.enroll(current_user)
    flash[:notice] = "Successfully enrolled!"
    redirect_to course_path(@course)
  end

  def unenroll
    @course = Course.find(params[:id])
    @course.unenroll(current_user)
    flash[:notice] = "Successfully Unenrolled!"
    redirect_to course_path(@course)
  end

  def taught
    @user = User.find(params[:id])
    @courses = @user == current_user ? @user.taught_courses : @user.public_taught_courses
    render 'index'
  end

  def enrolled
    @user = User.find(params[:id])
    @courses = @user == current_user ? @user.enrolled_courses : @user.public_enrolled_courses
    render 'index'
  end

  def all_courses
    @user = User.find(params[:id])
    @courses = @user == current_user ? @user.all_courses : @user.all_public_courses
    render 'index'
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :privacy)
  end
end

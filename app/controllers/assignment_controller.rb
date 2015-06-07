class AssignmentController < ApplicationController
  def new
    @course = Course.find(params[:course_id])
  end

  def show
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])
  end

  def index
    @course = Course.find(params[:course_id])
    @assignments = @course.assignments
  end

  def create
    @course = Course.find(params[:course_id])
    @assignment = @course.assignments.new(assignment_params)
    unless @assignment.valid?
      @assignment.destroy
      flash[:alert] = "Missing required fields"
      redirect_to new_course_assignment_path and return
    else
      @template = Project.find_by_name(params[:assignment][:template])
      if params[:assignment][:template] != "" and not @template
        @assignment.destroy
        flash[:alert] = "Invalid template project"
        redirect_to new_course_assignment_path and return
      else
        @assignment.template_id = @template ? @template.id : ""
      end
      @assignment.save
      flash[:notice] = "Assignment #{@assignment.title} successfully created"
      redirect_to course_assignment_index_path(@course)
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])
    @template = @assignment.template_id ? Project.find(@assignment.template_id).title : ""
  end

  def update
    @assignment = Assignment.find(params[:id])
    @assignment.update_attributes(assignment_params)
    unless @assignment.valid?
      flash[:notice] = "Missing required fields"
      redirect_to edit_course_assignment_path(@assignment) and return
    end
    @template = Project.find_by_name(params[:assignment][:template])
    if params[:assignment][:template] != "" and not @template
      @assignment.destroy
      flash[:alert] = "Invalid template project"
      redirect_to edit_course_assignment_path(id: @assignment.id) and return
    else
      @assignment.template_id = @template ? @template.id : ""
    end
    @assignment.save
    flash[:notice] = "#{@assignment.title} was successfully updated."
    redirect_to course_assignment_path(id: @assignment.id)
  end

  def destroy
    @course = Course.find(params[:course_id])
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    flash[:notice] = "Assignment '#{@assignment.title}' deleted."
    redirect_to course_assignment_index_path(@course)
  end

  def submit

  end

  private

  def assignment_params
    params.require(:assignment).permit(:title, :description, :start_time, :deadline)
  end
end

class Course < ActiveRecord::Base
  has_and_belongs_to_many :teachers, :class_name => "User", :join_table => 'course_teachers'
  has_and_belongs_to_many :students, :class_name => "User", :join_table => 'course_students'
  validates :title, presence: true
  after_update :remove_users

  def is_public?
  	return self.is_public
  end

  def remove_users
    # Input: Project (self)
    # Output: nil, Removes all users from the project

    self.teachers.each { |teacher| self.teachers.delete(teacher) }
  end

  def all_teachers
    string = ""
    self.teachers.each do |teacher|
      string += teacher.username
    end
    string
  end

  def add_teachers(users)
    users.each { |user| self.teachers << user }
  end

  def enroll(student)
    self.students << student
  end

  def unenroll(student)
    self.students.delete(student)
  end
end

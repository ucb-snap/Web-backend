class Course < ActiveRecord::Base
  has_and_belongs_to_many :teachers, :class_name => "User", :join_table => 'course_teachers'
  has_and_belongs_to_many :students, :class_name => "User", :join_table => 'course_students'
  validates :title, presence: true
  after_update :remove_teachers

  def is_public?
    # Input: Course (self)
    # Output: Boolean depicting if the course is public
  	return self.is_public
  end

  def all_teachers
    # Input: Course (self)
    # Output: String of the usernames for all teachers of the course

    accounts = []
    self.teachers.each { |teacher| accounts += [teacher.username] }
    accounts.join(", ").to_str
  end

  def remove_teachers
    # Input: Course (self)
    # Output: nil, Removes all teachers from the course

    self.teachers.each { |teacher| self.teachers.delete(teacher) }
  end

  def add_teachers(users)
    # Input: List of users to be added as teachers of the course
    # Output: nil, Adds users as teachers of the course

    users.each { |user| self.teachers << user }
  end

  def enroll(student)
    # Input: A student who is enrolling in the course
    # Output: nil, Adds student to the course

    self.students << student
  end

  def unenroll(student)
    # Input: A student who is un-enrolling from the course
    # Output: nil, Removes student from the course

    self.students.delete(student)
  end
end

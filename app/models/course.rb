class Course < ActiveRecord::Base
  has_and_belongs_to_many :teachers, :class_name => "User", :join_table => 'course_teachers'
  has_and_belongs_to_many :students, :class_name => "User", :join_table => 'course_students'
  validates :title, presence: true

  def is_public?
  	return self.is_public
  end

  def all_teachers
    string = ""
    self.teachers.each do |teacher|
      string += teacher.username
    end
    string
  end
end

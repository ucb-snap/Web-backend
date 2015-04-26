class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :taught_courses, :class_name => "Course", join_table: 'course_teachers'
  has_and_belongs_to_many :enrolled_courses, :class_name => "Course", join_table: 'course_students'
  has_and_belongs_to_many :projects, join_table: 'user_projects'
  has_many :comments
  has_and_belongs_to_many :conversations, join_table: 'user_conversations'
  has_many :messages

  def all_courses
  	courses = self.taught_courses + self.enrolled_courses
  end
end

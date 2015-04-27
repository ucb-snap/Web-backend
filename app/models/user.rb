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
    # Input: User (self)
    # Output: Array of courses the User is teaching and enrolled in

  	courses = self.taught_courses + self.enrolled_courses
  end

  def self.validate_emails(emails)
    # Input: Array of strings that represent email addresses
    # Output: Array with the following values:
    # => [boolean representing if all values are valid,
    #     list of all users, or a string of the invalid emails]

    valid = []
    invalid = ""
    all_valid = true
    emails.each do |email|
      user = find_by_email(email.to_s)
      unless user
        all_valid = false
        invalid += email + ", "
      else
        valid.append(user)
      end
    end
    list = all_valid ? valid : invalid[0..-3]
    [all_valid, list]
  end

  def self.add_project_to_users(users, project)
    users.each { |user| user.projects << project }
  end
end

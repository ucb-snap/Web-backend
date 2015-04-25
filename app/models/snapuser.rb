class Snapuser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :Snapprojects
  has_and_belongs_to_many :taught_classes, :class_name => "Snapclass", join_table: 'class_teachers'
  has_and_belongs_to_many :enrolled_classes, :class_name => "Snapclass", join_table: 'class_students'
  has_and_belongs_to_many :snapprojects, join_table: 'user_projects'
  has_many :Snapclasses
  has_many :snapcomments
  has_and_belongs_to_many :conversations, join_table: 'user_conversations'
  has_many :messages

  def all_classes
  	classes = self.taught_classes + self.enrolled_classes
  end
end

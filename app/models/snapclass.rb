class Snapclass < ActiveRecord::Base
  has_many :Snapassignments
  has_and_belongs_to_many :teachers, :class_name => "Snapuser", :join_table => 'class_teachers'
  has_and_belongs_to_many :students, :class_name => "Snapuser", :join_table => 'class_students'
  def is_public?
  	return self.is_public
  end
end

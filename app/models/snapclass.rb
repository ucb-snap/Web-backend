class Snapclass < ActiveRecord::Base
  has_many :Snapassignments
  belongs_to :teacher, :class_name => "Snapuser", :foreign_key => 'snapuser_id'
  has_many :students, :class_name => "Snapuser"
end

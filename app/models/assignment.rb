class Assignment < ActiveRecord::Base
  belongs_to :course
  belongs_to :template, class_name: "Project"
  has_many :submissions, class_name: "Project"
end

class Snapuser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :Snapgroups
  has_many :Snapprojects
  has_many :snapclasses

  def my_teaching_classes
  	classes = Snapclass.where(:teacher_id => self.id)
  end


  def my_taking_classes
  	# classes = Snapclass.where(:student_id => self.id)
    
  end

  def all_classes
  	# classes = Snapclass.where("is_public = ? OR teacher_id = ?", 1, self.id)
  end
end

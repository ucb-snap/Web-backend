class SnapClass

  attr_accessor :name
  attr_accessor :students
  attr_accessor :teacher
  attr_accessor :assignments

  def initialize(name, teacher)
    @name = name
    @students = []
    @teacher = teacher
    @assignments = []
  end

end

class SnapProject

  attr_accessor :name
  attr_accessor :user
  attr_accessor :file

  def initialize(name, user)
    @name = name
    @user = user
    @file = "Insert something here for the project file"
  end

end

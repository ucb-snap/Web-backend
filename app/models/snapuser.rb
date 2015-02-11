class SnapUser

  attr_accessor :username
  attr_accessor :password
  attr_accessor :email
  attr_accessor :type
  attr_accessor :projects
  attr_accessor :classes_enrolled
  attr_accessor :classes_teaching

  def initialize(username, password, email, type)
    @username = username
    @password = password
    @email = email
    @type = type
    @projects = []
    @classes_enrolled = []
    @classes_teaching = []
  end

  def createClass(class)

  end

  def deleteClass(class)

  end

  def createProject(project)

  end

  def deleteProject(project)

  end

end

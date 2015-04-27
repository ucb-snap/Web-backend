class Project < ActiveRecord::Base  
  has_and_belongs_to_many :users, join_table: 'user_projects'
  has_many :comments
  validates :name, presence: true
  after_update :remove_users

  def all_users
    string = ""
    self.users.each do |user|
      string += "#{user.username} "
    end
    string
  end

  def remove_users
    # Input: Project (self)
    # Output: nil, Removes all users from the project

    self.users.each { |user| self.users.delete(user) }
  end
end

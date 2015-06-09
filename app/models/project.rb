class Project < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: 'user_projects'
  has_many :comments
  belongs_to :assignment
  validates :name, presence: true
  after_update :remove_users

  def all_users
    # Input: Project (self)
    # Output: String of the usernames for all owners of the project

    accounts = []
    self.users.each { |user| accounts += [user.username] }
    accounts.join(", ").to_str
  end

  def remove_users
    # Input: Project (self)
    # Output: nil, Removes all users from the project

    self.users.each { |user| self.users.delete(user) }
  end

  def add_users(users)
    # Input: Array of users to be added to the project
    # Output: nil, Adds all users from the project

    users.each { |user| self.users << user }
  end
end

class Submission < Project

end

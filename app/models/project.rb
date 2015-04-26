class Project < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: 'user_projects'
  has_many :comments
  validates :name, presence: true

  def all_users
    string = ""
    self.users.each do |user|
      string += "#{user.username} "
    end
    string
  end
end

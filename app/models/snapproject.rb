class Snapproject < ActiveRecord::Base
  has_and_belongs_to_many :snapusers, join_table: 'user_projects'
  has_many :snapcomments
  validates :name, presence: true
end

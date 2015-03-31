class Snapproject < ActiveRecord::Base
  has_and_belongs_to_many :Snapusers, join_table: 'user_projects'
end

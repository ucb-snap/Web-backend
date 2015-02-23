class Snapuser < ActiveRecord::Base
  has_many :Snapgroups
  has_many :Snapprojects
  has_many :Snapclasses
end

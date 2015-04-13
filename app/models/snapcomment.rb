class Snapcomment < ActiveRecord::Base
	belongs_to :snapuser
	belongs_to :snapproject
end

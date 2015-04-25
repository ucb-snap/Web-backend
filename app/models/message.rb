class Message < ActiveRecord::Base
	belongs_to :snapuser
	belongs_to :conversation
	
end

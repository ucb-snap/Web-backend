class Conversation < ActiveRecord::Base
	has_and_belongs_to_many :users, join_table: 'user_conversations'
	has_many :messages

	def all_users
		accounts = []
	  self.users.each { |user| accounts += [user.username] unless accounts.include? user.username }
		accounts.join(" ").to_str
	end

	def check(accountes)
		accountes.sort!
		temp2 = self.users.sort
		accountes == temp2
	end

	def self.new_or_exitsing_conversation(user, accounts)
		conversation = nil
		conversations = user.conversations
		conversations.each do |convo|
			if convo.check(accounts)
				conversation = convo
				break
			end
		end
		conversation = conversation ? conversation : user.conversations.create
	end

	def add_users(users)
		users.each { |user| self.users << user }
	end
end

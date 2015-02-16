# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
snapusers = [{:username => 'Kyle', :password => '123', :email => 'berkeley.edu', :account_type => "basic"},
        {:username => 'Natasha', :password => '456', :email => 'berkeley.edu', :account_type => "basic"},
        {:username => 'Annie', :password => '789', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'Minh', :password => 'abc', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'Jens', :password => 'def', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'Dan', :password => 'ghi', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'Brian', :password => 'jkl', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'John', :password => 'mno', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'Smith', :password => 'pqr', :email => 'berkeley.edu', :account_type => "basic"},
          {:username => 'David', :password => 'stu', :email => 'berkeley.edu', :account_type => "basic"},
     ]

snapusers.each do |user|
  Snapuser.create(user)
end

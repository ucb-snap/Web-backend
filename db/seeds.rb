# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
snapusers = [{:username => 'Kyle', :password => '12345678', :password_confirmation => '12345678', :email => 'kyle@berkeley.edu', :account_type => "basic"},
        {:username => 'Natasha', :password => '12345678', :password_confirmation => '12345678', :email => 'natasha@berkeley.edu', :account_type => "basic"},
        {:username => 'Annie', :password => '12345678', :password_confirmation => '12345678', :email => 'annie@berkeley.edu', :account_type => "basic"},
          {:username => 'Minh', :password => '12345678', :password_confirmation => '12345678', :email => 'minh@berkeley.edu', :account_type => "basic"},
          {:username => 'Jens', :password => '12345678', :password_confirmation => '12345678', :email => 'jens@berkeley.edu', :account_type => "basic"},
          {:username => 'Dan', :password => '12345678', :password_confirmation => '12345678', :email => 'dan@berkeley.edu', :account_type => "basic"},
          {:username => 'Brian', :password => '12345678', :password_confirmation => '12345678', :email => 'brian@berkeley.edu', :account_type => "basic"},
          {:username => 'John', :password => '12345678', :password_confirmation => '12345678', :email => 'john@berkeley.edu', :account_type => "basic"},
          {:username => 'Smith', :password => '12345678', :password_confirmation => '12345678', :email => 'smith@berkeley.edu', :account_type => "basic"},
          {:username => 'David', :password => '12345678', :password_confirmation => '12345678', :email => 'david@berkeley.edu', :account_type => "basic"},
     ]

snapusers.each do |user|
  Snapuser.create!(user)
end

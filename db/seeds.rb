# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [{:username => 'Kyle', :password => '12345678', :password_confirmation => '12345678', :email => 'kyle@berkeley.edu'},
        {:username => 'Natasha', :password => '12345678', :password_confirmation => '12345678', :email => 'natasha@berkeley.edu'},
        {:username => 'Annie', :password => '12345678', :password_confirmation => '12345678', :email => 'annie@berkeley.edu'},
          {:username => 'Minh', :password => '12345678', :password_confirmation => '12345678', :email => 'minh@berkeley.edu'},
          {:username => 'Jens', :password => '12345678', :password_confirmation => '12345678', :email => 'jens@berkeley.edu'},
          {:username => 'Dan', :password => '12345678', :password_confirmation => '12345678', :email => 'dan@berkeley.edu'},
          {:username => 'Brian', :password => '12345678', :password_confirmation => '12345678', :email => 'brian@berkeley.edu'},
          {:username => 'John', :password => '12345678', :password_confirmation => '12345678', :email => 'john@berkeley.edu'},
          {:username => 'Smith', :password => '12345678', :password_confirmation => '12345678', :email => 'smith@berkeley.edu'},
          {:username => 'David', :password => '12345678', :password_confirmation => '12345678', :email => 'david@berkeley.edu'},
     ]

users.each do |user|
  User.create!(user)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..9]
followers = users[3..8]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Activity.all.destroy_all
Event.all.destroy_all
Group.all.destroy_all
User.all.destroy_all

puts "destroying seeds"


puts "creating acitivites"

activity1 = Activity.create!(
name: "basketball"
)

activity2 = Activity.create!(
name: "football"
)

activity3 = Activity.create!(
name: "swimming"
)

puts "creating users"


user1 = User.create!(
email: "user1@gmail.com",
password: "123456",
name: "user1"
)

user2 = User.create!(
email: "user2@gmail.com",
password: "123456",
name: "user2"
)


puts "creating groups"

group1 = Group.create!(
name: "group1",
description: "first group test",
city: "London",
user_id: user1.id
)

group2 = Group.create!(
name: "group2",
description: "second group test",
city: "London",
user_id: user2.id
)


puts "creating events"

event1 = Event.create!(
name: "test",
description: "first event test",
date: Date.new,
time: Time.now,
address: "London, Waterloo",
activity_id: activity1.id,
group_id: group1.id
)

event2 = Event.create!(
name: "test 2",
description: "second event test",
date: Date.new,
time: Time.now,
address: "London, Westminster",
activity_id: activity2.id,
group_id: group2.id
)
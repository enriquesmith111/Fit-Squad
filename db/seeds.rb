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


kevin = User.create!(
email: "user1@gmail.com",
password: "123456",
name: "Kevin",
avatar: "kevin_avatar.jpg"
)

linda = User.create!(
email: "user2@gmail.com",
password: "123456",
name: "Linda",
avatar: "linda_avatar.jpg",
)


puts "creating groups"

kevin_basketball = Group.create!(
name: "Kevin's Basketball Squad",
description: "first group test",
city: "London",
user_id: kevin.id,
group_image: "kevin_basketball.jpg"
)

linda_pilates = Group.create!(
name: "Linda Pilates",
description: "second group test",
city: "London",
user_id: linda.id,
group_image: "linda_pilates.jpg"
)


puts "creating events"

event1 = Event.create!(
name: "test",
description: "first event test",
date: Date.new,
time: Time.now,
address: "London, Waterloo",
activity_id: activity1.id,
group_id: kevin_basketball.id
)

event2 = Event.create!(
name: "test 2",
description: "second event test",
date: Date.new,
time: Time.now,
address: "London, Westminster",
activity_id: activity2.id,
group_id: linda_pilates.id
)
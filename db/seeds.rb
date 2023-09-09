require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "-----------------------------------------------"
puts "Destroying Seeds"
Activity.all.destroy_all
Event.all.destroy_all
Group.all.destroy_all
GroupParticipant.all.destroy_all
User.all.destroy_all
puts "-----------------------------------------------"



puts "-----------------------------------------------"
puts "Creating Acitivites"
football = Activity.create!(
    name: "Football" 
) 
p "Created #{football.name}"

running = Activity.create!(
    name: "Running" 
) 
p "Created #{running.name}"

swimming = Activity.create!(
    name: "Swimming" 
) 
p "Created #{swimming.name}"

athletics = Activity.create!(
    name: "Athletics" 
) 
p "Created #{athletics.name}"

powerlifting = Activity.create!(
    name: "Powerlifting" 
) 
p "Created #{powerlifting.name}"

rugby = Activity.create!(
    name: "Rugby" 
) 
p "Created #{rugby.name}"

tennis = Activity.create!(
    name: "Tennis" 
) 
p "Created #{tennis.name}"

volleyball = Activity.create!(
    name: "Volleyball" 
) 
p "Created #{volleyball.name}"

cycling = Activity.create!(
    name: "Cycling" 
) 
p "Created #{cycling.name}"

handball = Activity.create!(
    name: "Handball" 
) 
p "Created #{handball.name}"

rowing = Activity.create!(
    name: "Rowing" 
) 
p "Created #{rowing.name}"

weelchair_basketball = Activity.create!(
    name: "Wheelchair basketball" 
) 
p "Created #{weelchair_basketball.name}"
puts "-----------------------------------------------"





puts "-----------------------------------------------"
puts "Creating Users"
101.times do |i|
    user_name = Faker::Name.first_name
    user_email = "#{user_name + i.to_s}@gmail.com"
    user = "user" + (i).to_s
    User.create!(
        name: user_name,
        email: user_email,
        password: "123456",
        avatar: Faker::Avatar.image(size: "50x50")
    )
    p "#{i} Created User #{user_name}"
end
puts "-----------------------------------------------"





puts "-----------------------------------------------"
(1..13).each do |i|
    puts "Creating Group with Events"
    @group_id = i
    @num = (rand(5..10)) 
    user = User.find(i)
    user_id = User.find(i).id
    @activity = Activity.find(rand(1..12))
    @group = Group.create!(
        user_id: user_id,
        name: "#{user.name}'s" + " " +  "#{@activity.name} Group",
        description: "Hi Everyone and welcome to my #{@activity.name} Group",
        city: "London",
        group_image: "#{@activity.name}_group.jpg",
    )
    
    (rand(6..12)).times do |g|
        @participant = GroupParticipant.create!(
            group_id: @group_id,
            user_id: rand(1..100)
        )
        puts "#{i + 1} Created G Participant with id #{@participant.user_id} for Group #{i + 1} "
    end         




    puts "Creating Events for the Group now"
        (1..@num).each do |i|
            @event_id = i
            date = Date.today + rand(1..30)
            time = Time.now
            hour = time.hour
            minute = time.min
            second = time.sec
            time_string = " at #{hour}:#{minute}:#{second}"
            locations = ["Belgrave Square, Belgrave Sq, London, England SW1X 8PZ, United Kingdom", "Battersea Power Station, 188 Kirtling St, London, England SW11 8BZ, United Kingdom", "Westminster Bridge, Westminster Bridge Rd., London, England SW1A 2LW, United Kingdom", "Battersea Park, Albert Bridge Rd, London, England SW11 4NJ, United Kingdom", "Clapham Common West Side, London, England SW4 9BB, United Kingdom", "Richmond Park, Sawyer's Hill, Richmond, England TW10 5HZ, United Kingdom", "Primrose Hill, NW3 3AU, Camden, London, Greater London, England, United Kingdom", "Greenwich Park, Maze Hill, London, England SE10 8EJ, United Kingdom", "Hoxton, N1 6TJ, Hackney, London, Greater London, England, United Kingdom", "Waterloo, SE1 8DF, Southwark, London, Greater London, England, United Kingdom", "Kensington Gardens, Kensington Rd, London, England W2 3XA, United Kingdom", "Hammersmith, W6 9YA, Hammersmith and Fulham, London, Greater London, England, United Kingdom", "Westfield, Ariel Way, London, England W12 7FL, United Kingdom", "Hampstead, NW3 1TR, Camden, London, Greater London, England, United Kingdom", "Stratford, E15 4PG, Newham, London, Greater London, England, United Kingdom", "Pimlico Academy, Lupus St., London, England SW1V 3AP, United Kingdom", "Croydon Rd, Beckenham, England BR3 3FD, United Kingdom", "Wapping Old Stairs, London, England E1W 2PN, United Kingdom", "Brixton, SW2 1SS, Lambeth, London, Greater London, England, United Kingdom", "Canary Wharf College, London, England E14 3BA, United Kingdom", "Shoreditch House, Ebor Street, London, England E1 6AW, United Kingdom", "Paddington St, London, England W1U 4EG, United Kingdom", "Wimbledon, SW19 7NL, Merton, London, Greater London, England, United Kingdom", "Putney Hill, Putney Hill, London, England SW15 6RU, United Kingdom", "Chelsea Harbour, Chelsea Harbour, London, England SW10 0XB, United Kingdom", "Lewisham Town Hall, Catford Rd, London, England SE6 9SF, United Kingdom", "Camden Town, NW1 9PJ, Camden, London, Greater London, England, United Kingdom", "Chiswick Mall, London, England W4 2PR, United Kingdom", "Kingston upon Thames, Greater London, England, United Kingdom"]
            location = locations[rand(0..28)]
            name = "#{@activity.name} in #{location.to_s.gsub(",", "").split(" ")[0]}!"
            event = "event" + (i).to_s
            @event =
            @event = Event.create!(
                group_id: @group_id,
                address: location,
                name: name,
                date: date,
                time: Time.now,
                activity_id: @activity.id,
                event_image: "#{@activity.name}_event.jpg",
                description: "Join us for a day of fun and excitement at the #{name}! This event is for all ages and skill levels, so whether you're a seasoned athlete or just starting out, we're sure you'll have a great time. We'll have a variety of activities to choose from. There will also be food, drinks, and music, so you can relax and refuel after a day of fun. The event will take place on #{date} at #{time_string} at #{location}. Registration is required, so please sign up today! We hope to see you there!"
            )

            (rand(4..8)).times do |e|
                e + 1
                @participant = EventParticipant.create!(
                    event_id: @event_id,
                    user_id: rand(1..100)
                )
                p " Event number #{@event_id} Created E Participant with id #{@participant.user_id} for Event #{i + 1}"
            end
        puts "#{@event.id} finished Creating Event #{@event_id} #{@event.name} for Group #{@group.id} id"
    end
    puts "#{@group.id} finished Creating Group #{@group.name} and Events"
    puts "-----------------------------------------------"
    puts "-----------------------------------------------"

end







#     13.times do |i|
#         i + 1
#         (rand(6..12)).times do |g|
#         @participant = GroupParticipant.create!(
#             group_id: i + 1,
#             user_id: rand(1..100)
#         )
#         puts "#{i + 1} Created G Participant with id #{@participant.user_id} for Group #{i + 1} "
#     end         
#         p "Group #{i + 1} creating event participant"
#         (rand(4..8)).times do |e|
#         e + 1
#         EventParticipant.create!(
#             event_id: @event.id,
#             user_id: GroupParticipant.where(group_id: i + 1)[rand(0..6)].id
#         )
#         p "number #{@event.id} Created E Participant with id #{@participant.user_id} for Event #{i + 1}"
#         puts "-----------------------------------------------"
#     end
# end



# event1 = Event.create!(
# name: "Basketball in Waterloo!",
# description: "first event test",
# date: Date.today + 2,
# time: Time.now,
# address: "Waterloo, SE1 8DF, Southwark, London, Greater London, England, United Kingdom",
# activity_id: Activity.first.id,
# group_id: kevin_basketball.id,
# event_image: "kevin_basketball_event.jpg"
# )

# puts "creating events"


# activity1 = Activity.create!(
# name: "basketball"
# )

# activity2 = Activity.create!(
# name: "football"
# )

# activity3 = Activity.create!(
# name: "swimming"
# )

# activity4 = Activity.create!(
#     name: "swimming"
# )

# activity5 = Activity.create!(
#     name: "swimming"
# )



# kevin = User.create!(
# email: "user1@gmail.com",
# password: "123456",
# name: "Kevin",
# avatar: "kevin_avatar.jpg"
# )

# linda = User.create!(
# email: "user2@gmail.com",
# password: "123456",
# name: "Linda",
# avatar: "linda_avatar.jpg",
# )


# kevin_basketball = Group.create!(
# name: "Kevin's Basketball Squad",
# description: "first group test",
# city: "London",
# user_id: kevin.id,
# group_image: "kevin_basketball.jpg"
# )

# linda_pilates = Group.create!(
# name: "Linda Pilates",
# description: "second group test",
# city: "London",
# user_id: linda.id,
# group_image: "linda_pilates.jpg"
# )


# event1 = Event.create!(
# name: "Basketball in Waterloo!",
# description: "first event test",
# date: Date.today + 2,
# time: Time.now,
# address: "Waterloo, SE1 8DF, Southwark, London, Greater London, England, United Kingdom",
# activity_id: Activity.first.id,
# group_id: kevin_basketball.id,
# event_image: "kevin_basketball_event.jpg"
# )

# event2 = Event.create!(
# name: "Pilate day with Linda",
# description: "second event test",
# date: Date.today + 3,
# time: Time.now,
# address: "Westminster Abbey, 20 Dean's Yard, London, England SW1A 0AA, United Kingdom",
# activity_id: Activity.second.id,
# group_id: linda_pilates.id,
# event_image: "linda_pilates_event.jpg"
# )

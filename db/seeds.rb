require 'faker'

# Create 15 topics
topics = []
15.times do
  topics << Topic.create(
    name: Faker::Lorem.words(rand(1..10)).join(" "),
    description: Faker::Lorem.paragraph(rand(1..4))
    )
end

rand(4..10).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save

  # Note: by calling `User.new` instead of `create`,
  # we create an instance of a user which isn't saved to the database.
  # The `skip_confirmation!` method sets the confirmation date
  # to avoid sending an email. The `save` method updates the database.

  rand(5..12).times do
    topic = topics.first
    p = u.posts.create(
      topic: topic,
      title: Faker::Lorem.words(rand(1..10)).join(" "), 
      body: Faker::Lorem.paragraphs(rand(1..4)).join("\n"))
    # set the created_at to a time within the past year
    p.update_attribute(:created_at, Time.now - rand(600..31536000))
    p.update_rank
    topics.rotate! 
  end
end

u = User.new(
  name: 'Admin User',
  email: 'edrickepascual@gmail.com',
  password: 'swatch79',
  password_confirmation: 'swatch79',
)
u.skip_confirmation!
u.save
u.update_attribute(role: 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(role: 'moderator')


u = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

user_array = User.all
Comment.all.each do |comment|
  random_user = user_array[rand(user_array.length)]
  comment.user_id = random_user.user_id
  comment.save
end
puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"


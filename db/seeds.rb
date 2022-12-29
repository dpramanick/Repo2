# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# rubocop:disable Style/CombinableLoops

Condition.create([
                   { name: 'Poor',
                     description: 'Poor condition items have functional\
                    problems that will usually require repair or work. ' },
                   { name: 'Fair',
                     description: 'Fair items generally work, however,\
                      may have some minor functional or cosmetic issues.' },
                   { name: 'Good',
                     description: 'Good items are generally in\
                      good working order, however, may have some cosmetic blemishes.' },
                   { name: 'Excellent',
                     description: 'Excellent gear is in almost-new\
                      condition, free of blemishes and heavy use.' }
                 ])

Category.create([
                  { name: 'Guitar', description: 'Electric & Acoustic guitars.' },
                  { name: 'Bass', description: 'Bass guitars & other bass stringed instruments.' },
                  { name: 'Drums & Percussion',
                    description: 'Drum kits, drums & other percussive instruments.' },
                  { name: 'Synth & Keyboards', description: 'Pianos, keyboards & synthesizers.' },
                  { name: 'Amplifiers', description: 'Guitar, keyboard & general audio amplifiers.' },
                  { name: 'Pro Audio',
                    description: 'Professional audio equipment, such as PA systems & mixing desks.' }
                ])

(1..6).each do |_i|
  user = User.new(
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.email,
    password: 'password',
    postcode: rand(12_345...65_432),
    telephone: '8567486321',
    latitude: '65.784',
    longitude: '54.321'
  )
  user.save!
  puts "Created user #{user.name} "
end

(1..3).each do |_i|
  user = User.order('RANDOM()').first
  category = Category.order('RANDOM()').first
  condition = Condition.order('RANDOM()').first

  prod = Product.new(
    name: "#{Faker::Company.name} #{Faker::Music.instrument}",
    price: rand(5000..99_900),
    location: rand(12_345...65_432),
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    user_id: user.id,
    category_id: category.id,
    condition_id: condition.id,
    purchased: false,
    person: 'seller'
  )
  temp_prod_file = Down.download(Faker::LoremFlickr.image(size: '300x300', search_terms: %w[music instrument]))
  prod.picture.attach(io: temp_prod_file, filename: File.basename(temp_prod_file.path))

  prod.save!
  puts "Created a #{category.name} item called #{prod.name} belonging to #{user.name} in #{condition.name} condition."
end

(1..3).each do |_i|
  user = User.order('RANDOM()').first
  category = Category.order('RANDOM()').first
  condition = Condition.order('RANDOM()').first

  prod = Product.new(
    name: "#{Faker::Company.name} #{Faker::Music.instrument}",
    price: rand(5000..99_900),
    location: rand(12_345...65_432),
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    user_id: user.id,
    category_id: category.id,
    condition_id: condition.id,
    purchased: false,
    person: 'buyer'
  )
  temp_prod_file = Down.download(Faker::LoremFlickr.image(size: '300x300', search_terms: %w[music instrument]))
  prod.picture.attach(io: temp_prod_file, filename: File.basename(temp_prod_file.path))

  prod.save!
  puts "Created a #{category.name} item called #{prod.name} belonging to #{user.name} in #{condition.name} condition."
end

# rubocop:enable Style/CombinableLoops

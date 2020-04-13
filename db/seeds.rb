# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Authors
5.times do
  author =
    Author.create!({
      name: Faker::Name.unique.name
    })

  puts "Author created: #{author.name}"
end

10.times do
  book =
    Book.create!({
      title: Faker::Book.unique.title,
      author: Author.all.sample
    })

  puts "Book created: #{book.title}"
end

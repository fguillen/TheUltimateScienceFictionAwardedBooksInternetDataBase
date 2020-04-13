FactoryBot.define do
  factory :author do
    name { Faker::Name.unique.name }
  end

  factory :book do
    title { Faker::Book.unique.title }
    author
  end

  factory :award do
    name { Faker::TvShows::Simpsons.unique.character }
    category { "Novel" }
  end

  factory :award_winner do
    award
    book
    year { 2020 }
    position { "winner" }
  end
end

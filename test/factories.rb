FactoryBot.define do
  factory :author do
    name { Faker::Name.unique.name }
  end

  factory :book do
    title { Faker::Book.unique.title }
    author
  end
end

FactoryGirl.define do
  factory :organisation do
    name        { Faker::Lorem.word }
    email       { Faker::Internet.email }
    description { Faker::Lorem.sentence }
    url         { Faker::Internet.url }
    location    { Faker::Address.city }
  end
end

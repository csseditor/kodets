FactoryGirl.define do
  factory :organisation do
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
    description { Faker::Lorem.sentence }
    url { Faker::Internet.url }
    location { Faker::Address.city }
    teacher { build(:teacher) }
    after(:create) do |org|
      3.times { org.students << build(:student, organisation: org) }
    end
  end
end

FactoryGirl.define do
  factory :student do
    name { Faker::Lorem.word }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    organisation { build(:organisation) }
  end
end

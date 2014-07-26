FactoryGirl.define do
  factory :student do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }
    password_confirmation { password }
    organisation { create(:organisation) }
  end
end

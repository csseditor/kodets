FactoryGirl.define do
  factory :teacher do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    title { 'Mr.' }
    password { Faker::Internet.password }
    password_confirmation { password }
    organisation { create(:organisation) }
  end
end

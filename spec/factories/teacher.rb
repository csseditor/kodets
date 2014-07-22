FactoryGirl.define do
  factory :teacher do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password = Faker::Internet.password
    password password
    password_confirmation password
  end
end

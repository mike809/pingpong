FactoryGirl.define do
  factory :user, aliases: [:player_1, :player_2] do
    first_name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end

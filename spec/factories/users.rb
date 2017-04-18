FactoryGirl.define do
  factory :user, aliases: [:player_1, :player_2] do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end

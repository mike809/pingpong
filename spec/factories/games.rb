FactoryGirl.define do
  factory :game do
    player_1
    player_2
    player_1_score { 21 }
    player_2_score { Faker::Number.between(1, 18) }
  end
end

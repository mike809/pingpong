class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  validate :score_difference_greater_than_one
  validate :max_score

  validates_presence_of :player_1, :player_2, :player_1_score, :player_2_score

  after_create :compute_new_ratings

  def winner
    player_1_score > player_2_score ? player_1 : player_2
  end

  def opponent(user)
    opponent = user == player_1 ? player_2 : player_1
    opponent.first_name
  end

  def score(user)
    if user == player_1
      user_score, other_user_score = player_1_score, player_2_score
    else
      user_score, other_user_score = player_2_score, player_1_score
    end

    "#{user_score}-#{other_user_score}"
  end

  def result(user)
    user == winner ? 'W' : 'L'
  end

  def date
    created_at.strftime('%b %e')
  end

  private def compute_new_ratings(k_value=32,should_round=true)
    result = player_1_score > player_2_score ? 1 : 0
    player_1_result = result
    player_2_result = 1 - result

    #Calculate expected results
    player1_expectation = 1.0/(1+10**((player_2.rating - player_1.rating)/400.0)) #the .0 is important to force float operations!))
    player2_expectation = 1.0/(1+10**((player_1.rating - player_2.rating)/400.0))

    #Calculate new ratings
    player1_new_rating = player_1.rating + (k_value*(player_1_result - player1_expectation))
    player2_new_rating = player_2.rating + (k_value*(player_2_result- player2_expectation))

    #Optional rounding
    if should_round
      # int rounds down and forces type
      player1_new_rating = player1_new_rating.round
      player2_new_rating = player2_new_rating.round
    end

    player_1.update_attribute(:rating, player1_new_rating)
    player_2.update_attribute(:rating, player2_new_rating)
  end

  private def max_score
    unless [player_1_score, player_2_score].max <= 21 || score_difference == 2
      errors.add(:max_score, 'Score exceeds the maximum of 21')
    end
  end

  private def score_difference
    (player_1_score - player_2_score).abs
  end

  private def score_difference_greater_than_one
    unless score_difference > 1
      errors.add(:score_difference, 'Have to win game by 2 or more points')
    end
  end
end

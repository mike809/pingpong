# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  player_1_id    :integer
#  player_2_id    :integer
#  player_1_score :integer
#  player_2_score :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:player_1_score) { 21 }
  let(:player_2_score) { 15 }
  let(:winner) { FactoryGirl.create(:user) }
  let(:loser) { FactoryGirl.create(:user) }

  subject(:game) do
    FactoryGirl.build :game, {
      player_1: winner,
      player_2: loser,
      player_1_score: player_1_score,
      player_2_score: player_2_score
    }
  end

  context 'when we create a game with player 1 as a winner' do
    let(:initial_rating) { 1000 }

    before do
      subject.save
    end

    it 'has a the correct winner' do
      expect(game.winner).to be game.player_1
    end

    it 'increases the rating of the winner' do
      expect(winner.rating).to be > initial_rating
    end

    it 'decreases the rating of the loser' do
      expect(loser.rating).to be < initial_rating
    end
  end

  context 'when we create a game with player 2 as a winner' do
    let(:player_1_score) { 1 }
    let(:player_2_score) { 21 }

    it 'has a the correct winner' do
      expect(game.winner).to be game.player_2
    end
  end

  context 'when we create a game with score maximum score greater than 21' do
    let(:player_1_score) { 1 }
    let(:player_2_score) { 23 }

    it 'is not a valid game' do
      expect(game).not_to be_valid
    end

    context 'when the difference is two' do
      let(:player_1_score) { 21 }

      it 'is a valid game' do
        expect(game).to be_valid
      end
    end
  end
end

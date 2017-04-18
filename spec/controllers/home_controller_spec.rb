require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  context 'when we create a new game' do
    let(:opponent) { FactoryGirl.create(:user) }
    let(:date_played) { Faker::Date.between(2.days.ago, Date.today) }
    let(:attributes_for_game) { FactoryGirl.attributes_for(:game) }

    subject :log_game do
      post :log_game, attributes_for_game.merge(opponent: opponent)
    end

    # it 'creates a new game' do
    #   expect{ log_game }.to change{ Game.count }.by(1)
    # end
  end
end

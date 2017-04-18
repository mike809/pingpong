# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  rating                 :integer          default("1000")
#  first_name             :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  context 'when we create a new user' do
    it 'has a raking of 1000' do
      expect(user.rating).to eq 1000
    end
  end

  context 'when we have multiple users' do
    let(:other_user) { FactoryGirl.create(:user, rating: 1500) }
    let(:sorted_users) { User.unscoped.sort_by(&:score).reverse }

    before do
      user.save
      other_user
    end

    it 'orders them by score as default scope' do
      expect(User.all).to eq sorted_users
    end
  end
end

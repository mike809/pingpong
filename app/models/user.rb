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
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  default_scope { order('rating DESC') }

  alias_attribute :score, :rating

  def games
    Game.where('player_1_id = ? OR player_2_id = ?', self.id, self.id)
  end

  def games_played
    games.count
  end
end

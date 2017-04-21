class HomeController < ApplicationController
  def index
    # Probably paginate if too many.
    @users = User.all
  end

  def history
  end

  def log
    @users = User.where.not(id: current_user.id)
  end

  def log_game
    opponent = User.find(params[:opponent])

    game = Game.new({
      player_1: current_user,
      player_2: opponent,
      player_1_score: params[:your_score],
      player_2_score: params[:their_score],
      date_played: Date.new(*params[:date_played].sort.map{ |date| date.last.to_i })
    })

    if game.save
      redirect_to :history
    else
      render plain: game.errors.messages
    end
  end
end

class HomeController < ApplicationController
  def index
    # Probably paginate if too many.
    @users = User.all
  end

  def history
  end

  def log
  end
end

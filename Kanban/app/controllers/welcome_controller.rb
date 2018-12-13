class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to boards_path
    end
  end
end

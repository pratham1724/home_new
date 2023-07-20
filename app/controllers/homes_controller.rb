class HomesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.client?
        redirect_to trainers_path
      elsif current_user.trainer?
        redirect_to trainer_path(current_user)
      end
    end
  end
end

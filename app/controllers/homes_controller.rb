class HomesController < ApplicationController
  def index
    if user_signed_in?
      if current_user.client?
        if current_user.client.present?
          redirect_to client_path(current_user)
        else
          redirect_to new_client_path
        end
      elsif current_user.trainer?
        if current_user.trainer.present?
          redirect_to trainer_path(current_user)
        else
          redirect_to new_trainer_path
        end
      end
    end
  end
end

class RatingsController < ApplicationController
  # before_action :authenticate_user!, only: [:create, :update]
  # before_action :check_client_role, only: [:create, :update]

  def new
  end

  def create
    # @rating = current_user.ratings.new(rating_params)
    @trainer = Trainer.find(params[:trainer_id])
    @rating = current_user.client.ratings.new(rating_params.merge(trainer: @trainer))
    if @rating.save
      redirect_to @rating.trainer, notice: "Rating submitted successfully."
    else
      redirect_to @rating.trainer, alert: "Failed to submit rating."
    end
  end

  # def edit
  #   @rating = Rating.find(params[:id])
  #   @trainer = @rating.trainer
  #   #  @rating = current_user.client.ratings.find_by(trainer_id: @trainer.id)
  # end

  # def update
  #   @rating = Rating.find(params[:id])
  #   @trainer = @rating.trainer
  #   # @rating = current_user.client.ratings.find_by(trainer_id: @trainer.id)
  #   if @rating.update(rating_params)
  #     redirect_to @rating.trainer, notice: "Rating updated successfully."
  #   else
  #     redirect_to @rating.trainer, alert: "Failed to update rating."
  #   end
  # end


  def edit
    @rating = Rating.find(params[:id])
    @trainer = @rating.trainer
  end

  # app/controllers/ratings_controller.rb
def update
  @rating = Rating.find(params[:id])
  if @rating.update(rating_params)
    puts "Rating successfully updated!" # Add this line for debugging
    redirect_to @rating.trainer, notice: "Rating updated successfully."
  else
    puts @rating.errors.full_messages # Add this line to display any validation errors in the console
    redirect_to edit_rating_path(@rating), alert: "Failed to update rating."
  end
end


  def show
    @rating = Rating.find(params[:id])
    @trainer = @rating.trainer
    @client = @rating.client

    @ratings = @trainer.ratings
    # Add any additional code related to displaying individual rating details
  end

  private

  def rating_params
    params.require(:rating).permit(:value, :trainer_id)
  end
end











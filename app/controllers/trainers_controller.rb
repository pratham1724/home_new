class TrainersController < ApplicationController
  before_action :authenticate_user!

  def index
     @trainers = User.where(role: :trainer).joins(:trainer)
    #  @trainers = User.joins(:trainer).where("users.role = ?", "trainer")
  end

  def show
    @trainer = Trainer.find_by(params[:id])

    if @trainer.nil?
      # If no trainer found, handle the situation appropriately (e.g., redirect to the trainers index page)
      redirect_to trainers_path, alert: 'Trainer not found.'
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

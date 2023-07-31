class TrainersController < ApplicationController
  before_action :authenticate_user!

  def index
     @trainers = User.where(role: :trainer).joins(:trainer)
    #  @trainers = User.joins(:trainer).where("users.role = ?", "trainer")
  end

  def show
    if current_user.role == "client"
      @trainer = Trainer.find(params[:id])
      @ratings = @trainer.ratings
    else
      # @appointent = Appointment.find_by(trainer_id:@trainer.id).client
      @trainer = current_user.trainer
      @ratings = @trainer.ratings
    end

    if @trainer.nil?
      # If no trainer found, handle the situation appropriately (e.g., redirect to the trainers index page)
      redirect_to trainers_path, alert: 'Trainer not found.'
    end
  end

  def new
    @trainer = current_user.build_trainer
  end

  def create
    @trainer = current_user.build_trainer(trainer_params)
    if @trainer.save
      redirect_to trainer_path(current_user)
    else
      render :new
    end
  end
  
  def show_clients
    # @all_clients = Client.joins(appointments: :trainer).where("appointments.trainer_id = ?", @trainer.id )
    @trainer = current_user.trainer
    @all_clients = Client.includes(appointments: :trainer).where("appointments.trainer_id =?", @trainer.id).references(:trainer)
    # @all_clients.each do |c|
    #   c.name
    # end
  end
  
  def edit
    @trainer = Trainer.find(params[:id])
  end

  def update
  end

  def destroy
    @trainer = Trainer.find(params[:id])
    if @trainer.update(trainer_params)
      redirect_to @trainer, notice: 'trainer was successfully updated.'
    else
      render :edit
    end
  end

  def trainer_params
    params.require(:trainer).permit(:name, :age, :phone_number, :experience, :training_type, :profile)
  end
  

end

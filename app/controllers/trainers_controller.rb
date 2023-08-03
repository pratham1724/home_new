class TrainersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trainer, only: [:show, :show_pendings]
  load_and_authorize_resource

  def index
    @trainers = User.where(role: :trainer).joins(:trainer).paginate(page: params[:page], per_page: 3)
  end

  def show
    @ratings = @trainer.ratings  # @trainer is already set in the before_action callback
    if @trainer.nil?
      redirect_to trainers_path, alert: 'Trainer not found.'  # If no trainer found
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
    @trainer = current_user.trainer
    @all_clients = Client.includes(appointments: :trainer).where("appointments.trainer_id =?", @trainer.id).references(:trainer)
  end

  def show_pendings
    @appointments = Appointment.where('trainer_id = ?', @trainer.id).where(appointments: {confirmed: nil})
  end
  
  def edit
    @trainer = Trainer.find(params[:id])
  end

  def update
    @trainer = Trainer.find(params[:id])
    if @trainer.update(trainer_params)
      redirect_to @trainer, notice: 'trainer was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  def trainer_params
    params.require(:trainer).permit(:name, :age, :phone_number, :experience, :training_type, :profile)
  end
  
  def set_trainer
    if current_user.client?
      @trainer = Trainer.find(params[:id])
    else
      @trainer = current_user.trainer
    end
  end

end

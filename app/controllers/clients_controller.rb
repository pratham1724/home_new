class ClientsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 5)
    # if current_user.role == "trainer"
    #   @trainer = current_user.trainer
    #   @all_clients = Client.includes(appointments: :trainer).where("appointments.trainer_id =?", @trainer.id).references(:trainer)
    #   @client = @all_clients.find(params[:client_id])
    # end
  end

  def show
    if current_user.role == "client"
      @client = current_user.client
    else
      # @trainer = current_user.trainer
      # @all_clients = Client.includes(appointments: :trainer).where("appointments.trainer_id =?", @trainer.id).references(:trainer)
      # @client = @all_clients.find(params[:client_id])
      @client = Client.find(params[:id])
    end
  end

  def new
    @client = current_user.build_client
  end

  def create
    @client = current_user.build_client(client_params)
    if @client.save
      redirect_to client_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def client_params
    params.require(:client).permit(:name, :age, :phone_number, :profile)
  end

end


class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :show_trainers]
  load_and_authorize_resource
  
  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 5)
    
  end

  def show
     # @client is already set in the before_action callback
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

  def show_trainers
    @all_trainers = Trainer.includes(appointments: :client).where("appointments.client_id =?", @client.id).references(:client)
  end

  def destroy
  end

  private

  def client_params
    params.require(:client).permit(:name, :age, :phone_number, :profile)
  end

  def set_client
    if current_user.client?
      @client = current_user.client
      
    else
      @client = Client.find(params[:id])
    end
  end

end


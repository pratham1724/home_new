class ClientsController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
  end

  def new
    @client = current_user.build_client
  end

  def create
    @client = current_user.build_client(client_params)
    if @client.save
      redirect_to trainers_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def client_params
    params.require(:client).permit(:name, :age, :phone_number)
  end

end


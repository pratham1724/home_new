class AppointmentsController < ApplicationController
  before_action :authenticate_client!

  def new
    @trainer = Trainer.find(params[:trainer_id])
    @appointment = current_client.appointments.new(trainer: @trainer)
  end

  def create
    @trainer = Trainer.find(params[:trainer_id])
    @appointment = current_client.appointments.new(trainer: @trainer)

    if @appointment.save
      # Send the appointment confirmation email to the trainer
      AppointmentMailer.appointment_request(@appointment).deliver_now

      redirect_to @trainer, notice: 'Appointment request sent successfully.'
    else
      render :new
    end
  end

  def confirm
    @appointment = Appointment.find(params[:id])
    @appointment.update(confirmed: true)
    redirect_to @appointment.trainer, notice: 'Appointment confirmed successfully.'
  end

  # Rest of the actions (edit, update, destroy)
  
  private

  def appointment_params
    params.require(:appointment).permit(:trainer_id, :client_id, :confirmed)
  end
end

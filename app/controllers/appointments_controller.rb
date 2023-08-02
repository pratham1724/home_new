class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_client, only: [:new, :create]
  before_action :authorize_trainer, only: [:confirm, :reject]
  before_action :set_trainer, only: [:new, :create]
  before_action :set_appointment, only: [:confirm, :reject]

  def new
    if current_user.client.present?
      @appointment = current_user.client.appointments.new(trainer: @trainer)
    else
      redirect_to root_path, alert: "You are not authorized to schedule appointments as a client."
    end
  end

  def create
    @appointment = current_user.client.appointments.new(appointment_params.merge(trainer: @trainer))

    if @appointment.save
      AppointmentMailer.appointment_request(@appointment).deliver_now
      redirect_to @trainer, notice: 'Appointment request sent successfully.'
    else
      render :new
    end
  end

  def confirm
    @appointment.update(confirmed: true)
    AppointmentMailer.appointment_confirmation(@appointment).deliver_now
    redirect_to @appointment.trainer, notice: 'Appointment confirmed successfully.'
  end

  def reject
    @appointment.destroy
    redirect_to @appointment.trainer, notice: 'Appointment rejected successfully.'
  end

  private

  def appointment_params
    params.require(:appointment).permit(:client_id, :confirmed)
  end

  def authorize_client
    redirect_to root_path, alert: "Access denied. Only clients can schedule appointments." unless current_user.client?
  end

  def authorize_trainer
    redirect_to root_path, alert: "Access denied. Only trainers can confirm or reject appointments." unless current_user.trainer?
  end

  def set_trainer
    @trainer = Trainer.find(params[:trainer_id])
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end

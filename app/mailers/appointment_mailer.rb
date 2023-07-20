class AppointmentMailer < ApplicationMailer
  def appointment_request(appointment)
    @appointment = appointment
    @trainer = appointment.trainer
    @client = appointment.client
    @trainer_user = @trainer.user # Access the associated User model for the Trainer
    @client_user = @client.user # Access the associated User model for the Client

    mail(to: @trainer_user.email, subject: 'Appointment Request')
  end

  def appointment_confirmation(appointment)
    @appointment = appointment
    @trainer = appointment.trainer
    @client = appointment.client
    @trainer_user = @trainer.user # Access the associated User model for the Trainer
    @client_user = @client.user # Access the associated User model for the Client
    mail(to: @client_user.email, subject: 'Appointment Confirmation')
  end
end


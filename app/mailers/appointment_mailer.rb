class AppointmentMailer < ApplicationMailer
  def appointment_request(appointment)
    @appointment = appointment
    @trainer = appointment.trainer
    mail(to: @trainer.email, subject: 'Appointment Request')
  end
end

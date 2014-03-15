class AppointmentsController < ApplicationController
  before_filter :is_login
  
  def new
    
  end
  
  def create
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
    else
      render :new
    end
  end
end

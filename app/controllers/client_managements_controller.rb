class ClientManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    @client = Client.find(params[:id])
    @documents = @client.documents
    @document = Document.new
    @reminder = Reminder.new
    session[:ap_id] = params[:appointment_id] if params[:appointment_id]
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
  end
  
  def upload_document
    @client = Client.find(params[:id])
    @documents = @client.documents
    @reminder = Reminder.new
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @document = Document.new(params[:document])
    if @document.save
      redirect_to client_management_path(@client)
    else
      render :action => :show
    end
  end
end

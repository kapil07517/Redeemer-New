class ClientManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    @client = Client.find(params[:id])
    @documents = @client.documents.order("created_at desc")
    @document = Document.new
    @reminder = Reminder.new
    session[:ap_id] = params[:appointment_id] if params[:appointment_id]
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    render :layout => "counselor" if current_user.role == 'admin'
  end
  
  def upload_document
    @client = Client.find(params[:id])
    @documents = @client.documents.order("created_at desc")
    @reminder = Reminder.new
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @document = Document.new(params[:document])
    if @document.save
      redirect_to client_management_path(@client)
    else
      if current_user.role == 'admin'
        render :action => :show,:layout => "counselor"
      else
        render :action => :show
      end
    end
  end
  
  def search_form
    @appointment = Appointment.find(params[:appointment_id])
    render
  end
  
  def search
    @appointment = Appointment.find(params[:appointment_id])
    @clients = Client.where("first_name LIKE '%#{params[:search][:client_name]}%'")
    render
  end
  
  def add_client
    @appointment = Appointment.find(params[:appointment_id])
    @client = Client.find(params[:id])
    CaseClient.create(:case_id => @appointment.case_id,:client_id => @client.id) if !CaseClient.exists?(:case_id => @appointment.case_id,:client_id => @client.id)
    render
  end
  
end

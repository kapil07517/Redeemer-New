class CaseManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents.order("created_at desc")
    @document = Document.new
    session[:ap_id] = params[:appointment_id] if params[:appointment_id]
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @acccount = PayerAccount.where("case_id = #{@case.id} and client_id = #{@appointment.client.id}").last
    @authcounts = SessionPayment.where("case_id = #{@case.id} and client_id = #{@appointment.client.id}").count
  end
  
  def upload_document
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents.order("created_at desc")
    @document = Document.new(params[:document])
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    if @document.save
      redirect_to case_management_path(@case)
    else
      render :action => :show
    end
  end
end

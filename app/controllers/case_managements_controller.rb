class CaseManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents
    @document = Document.new
    @appointment = Appointment.find(params[:appointment_id]) if params[:appointment_id]
  end
  
  def upload_document
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents
    @document = Document.new(params[:document])
    if @document.save
      redirect_to case_management_path(@case)
    else
      render :action => :show
    end
  end
end

class DocumentsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def index
    @client = Client.find(params[:client_id])
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @documents = @client.documents
    @document = Document.new
  end
  
  def case_documents
    @case = Case.find(params[:case_id])
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @documents = @case.documents
    @document = Document.new
  end
  
  def create
    @case = Case.find(params[:case_id])
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    if params[:client_document][:document].blank?
      @blank = true
    else
      @doc = params[:client_document][:document]
      @blank = false
    end
  end
  
  def upload_client_document
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @client = Client.find(params[:client_id])
    if params[:client_document][:document].blank? and params[:client_document][:case_num].blank?
      @blank = true
      @doc_error = "can't be blank"
      @cas_error = "can't be blank"
    elsif params[:client_document][:document].blank?
      @blank = true
      @doc_error = "can't be blank"
    elsif params[:client_document][:case_num].blank?
      @blank = true
      @cas_error = "can't be blank"
    else
      @doc = params[:client_document][:document]
      @blank = false
    end
  end
  
  def show
    @document = Document.find(params[:id])
  end
end

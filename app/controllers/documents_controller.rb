class DocumentsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def index
    @client = Client.find(params[:client_id])
    @documents = @client.documents
    @document = Document.new
  end
  
  def case_documents
    @case = Case.find(params[:case_id])
    @documents = @case.documents
    @document = Document.new
  end
  
  def create
    if params[:case_id]
      @case = Case.find(params[:case_id])
      @client = @case.intake_form.user
      if params[:client_document][:document].blank?
        @blank = true
      else
        @doc = params[:client_document][:document]
        @blank = false
      end
    else
    end
  end
  
  def show
    @document = Document.find(params[:id])
  end
end

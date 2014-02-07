class DocumentsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def index
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @documents = @client.documents
    else
      @case = Case.find(params[:case_id])
      @documents = @case.documents
    end
    @document = Document.new
  end
end

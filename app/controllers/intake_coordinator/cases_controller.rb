class IntakeCoordinator::CasesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user,:except => :update
  
  def index
    if params[:query] and params[:query] != "all"
      @cases = Case.where("status = '#{params[:query]}'")
    else
      @cases = Case.all
    end
  end
  
  def new
    @intake_forms = IntakeForm.where("case_id IS NULL")
    @cases = Case.all
    @case = Case.new
  end
  
  #creating case number
  def create
    @intake_forms = IntakeForm.where("case_id IS NULL")
    @cases = Case.all
    @intake_form = IntakeForm.find params[:case][:intake_form_id]
    respond_to do |format|
      @case = Case.new(params[:case])
      @intake_ids = params[:other_intakes]
      if @case.save
        CaseClient.create(:case_id => @case.id,:client_id => @intake_form.user_id)
        CaseIntakeForm.create(:case_id =>@case.id,:intake_form_id => @case.intake_form_id)
        @intake_form.update_attribute(:case_id,@case.id)
        update_doc(@intake_form.id,@case.id)
        if params[:other_intakes]
          params[:other_intakes].split(",").each do |int|
            intake = IntakeForm.find(int).update_attribute(:case_id,@case.id) unless int.nil?
            CaseClient.create(:case_id => @case.id,:client_id => intake.user_id) if (intake and !CaseClient.exists?(:case_id => @case.id,:client_id => intake.user_id))
            update_doc(int,@case.id)
          end
        end
      end
      format.js
    end
  end
  
  def search_cases
    @intake_ids = params[:intake_id]
    @cases = Case.where("case_name LIKE '%#{params[:search]}%'")
  end
  
  def assign_case
    respond_to do |format|
      if params[:case_id] and !params[:intake_ids].blank?
        params[:intake_ids].split(",").each do |int|
          intake = IntakeForm.find(int).update_attribute(:case_id,params[:case_id]) unless int.nil?
          CaseClient.create(:case_id => params[:case_id],:client_id => intake.user_id) if (intake and !CaseClient.exists?(:case_id => params[:case_id],:client_id => intake.user_id))
          update_doc(int,params[:case_id])
        end
        @redirect = true
      else
        @redirect = false
        if params[:case_id]
          @alert = "First you need to select intake from above box!"
        else
          @alert = "Assign a case before proceeding!"
        end
      end
      format.js
    end
  end
  
  def update
    @case = Case.find(params[:id])
    @case.update_attribute(:status, params[:status])
    respond_to do |format|
      format.js { head :no_content }
    end
  end
  
  def show
    @case = Case.find(params[:id])
    @documents = @case.documents
    @document = Document.new
    @client_document = ClientDocument.new
  end
  
  def update_doc(int,cs)
    doc = Document.find_by_intake_form_id(int)
    if doc
      doc.update_attribute(:case_id,cs)
    end
  end
end

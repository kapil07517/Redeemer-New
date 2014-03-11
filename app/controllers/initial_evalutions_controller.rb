class InitialEvalutionsController < ApplicationController
  
  def new
    @case = Case.find(params[:case_id])
    @client = @case.intake_form.user
    @intake_evalution = IntakeEvalution.new
  end
  
  def create
    @case = Case.find(params[:intake_evalution][:case_id])
    @client = @case.intake_form.user
    @intake_evalution = IntakeEvalution.new(params[:intake_evalution])
    if @intake_evalution.save
      @document = Document.new(:user_id => current_user.id,:case_id =>@case.id,:client_id =>@client.id,:intake_evalution_id => @intake_evalution.id,:doc_type => "intake_evalution")
      @document.save(:validate => false)
      redirect_to edit_initial_evalution_path(current_user.role,@intake_evalution)
    else
      render :action => :new
    end
  end
  
  def client_intake_evalution
    @client = Client.find(params[:id])
    @intake_evalution = IntakeEvalution.new
  end
  
  def client_intake
    @client = Client.find(params[:intake_evalution][:client_id])
    @intake_evalution = IntakeEvalution.new(params[:intake_evalution])
    if @intake_evalution.save
      @document = Document.new(:user_id => current_user.id,:client_id =>@client.id,:intake_evalution_id => @intake_evalution.id,:doc_type => "intake_evalution")
      @document.save(:validate => false)
      redirect_to edit_initial_evalution_path(current_user.role,@intake_evalution)
    else
      render :action => :client_intake_evalution
    end
  end
  
  def edit
    @intake_evalution = IntakeEvalution.find(params[:id])
  end
  
  def update
    @intake_evalution = IntakeEvalution.find(params[:id])
    if @intake_evalution.update_attributes(params[:intake_evalution])
      redirect_to edit_initial_evalution_path(current_user.role,@intake_evalution)
    else
      render :action => :edit
    end
  end
end

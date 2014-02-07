class Client::FinancialsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @financial = Personal.new
    @intake_type = params[:intake_type]
  end
  
  def create
    @financial = Personal.new(params[:personal])
    @intake_type = params[:personal][:intake_type]
    @financial.client_id = current_user.id
    if @financial.save
      @intake_form = IntakeForm.new(:intake_type =>  @intake_type,:user_id => current_user.id,:intake_status => "processing")
      @intake_form.save
      @document = Document.new(:client_id =>current_user.id,:intake_form_id => @intake_form.id,:doc_type => "intake_form")
      @document.save(:validate => false)
      @financial.update_attribute(:intake_form_id,@intake_form.id)
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
end

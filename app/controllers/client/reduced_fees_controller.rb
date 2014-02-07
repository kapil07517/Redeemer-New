class Client::ReducedFeesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @reduced_fee = ReducedFee.new
    @intake_type = params[:intake_type]
    2.times{@reduced_fee.dependents.build}
  end
  
  def create
    @reduced_fee = ReducedFee.new(params[:reduced_fee])
    @reduced_fee.client_id = current_user.id
    @intake_type = params[:reduced_fee][:intake_type]
    if @reduced_fee.save
      @intake_form = IntakeForm.new(:user_id => current_user.id,:intake_type => @intake_type,:intake_status => "processing")
      @intake_form.save
      @document = Document.new(:client_id =>current_user.id,:intake_form_id => @intake_form.id,:doc_type => "intake_form")
      @document.save(:validate => false)
      @reduced_fee.update_attribute(:intake_form_id,@intake_form.id)
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
end

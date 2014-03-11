class Client::CareerAssessmentsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @career_assesment = Personal.new
    @intake_type = params[:intake_type]
  end
  
  def create
    @career_assesment = Personal.new(params[:personal])
    @intake_type = params[:personal][:intake_type]
    @career_assesment.client_id = current_user.id
    if current_user.valid_password?(params[:personal][:password])
      if @career_assesment.save
        @intake_form = IntakeForm.new(:intake_type =>  @intake_type,:user_id => current_user.id,:intake_status => "processing")
        @intake_form.save
        @document = Document.new(:user_id => current_user.id,:client_id =>current_user.id,:intake_form_id => @intake_form.id,:doc_type => "intake_form")
        @document.save(:validate => false)
        @career_assesment.update_attribute(:intake_form_id,@intake_form.id)
        redirect_to root_path
      else
        render :action => :new
      end
    else
      @career_assesment.errors.add(:password,'Entered password is wrong.Please try again!')
      render :action => :new
    end
  end
end

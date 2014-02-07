class Client::IndividualsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @individual = Counseling.new
    @intake_type = params[:intake_type]
    @start_date = Date.today
    @end_date = Date.today+7.days
  end
  
  #intake form with type individual
  def create
    @individual = Counseling.new(params[:counseling])
    @individual.client_id = current_user.id
    @intake_type = params[:counseling][:intake_type]
    @start_date = Date.today
    @end_date = Date.today+7.days
    if @individual.save
      @intake_form = IntakeForm.new(:intake_type =>  @intake_type,:user_id => current_user.id,:intake_status => "processing")
      @intake_form.save
      @document = Document.new(:client_id =>current_user.id,:intake_form_id => @intake_form.id,:doc_type => "intake_form")
      @document.save(:validate => false)
      if params[:times]
        params[:times].each do |tim|
          ClientAvailability.create(:start_at => tim.split(',')[0],:end_at => tim.split(',')[1],:client_id => current_user.id,:intake_form_id => @intake_form.id)
        end
      end
      @individual.update_attribute(:intake_form_id,@intake_form.id)
      redirect_to medical_client_individual_path(@intake_form)
    else
      render :action => :new
    end
  end
  
  #client medical information form
  def medical
    @intake_form = IntakeForm.find params[:id]
    @medical = Medical.new
    1.times{@medical.medical_reasons.build}
    2.times{@medical.medications.build}
    1.times{@medical.therapists.build}
  end
  
  #updating intake form medical information
  def medical_information
    @intake_form = IntakeForm.find params[:id]
    @medical = Medical.new(params[:medical])
    @medical.intake_form_id = @intake_form.id
    @medical.client_id = current_user.id
    if @medical.save
      redirect_to personal_client_individual_path(@intake_form)
    end
  end
  
  def personal
    @intake_form = IntakeForm.find params[:id]
    @personal = Personal.new
  end
  
  def personal_information
    @intake_form = IntakeForm.find params[:id]
    @personal = Personal.new(params[:personal])
    @personal.intake_form_id = @intake_form.id
    @personal.client_id = current_user.id
    if @personal.save
      if session[:is_minor] == "yes"
        session[:is_minor] = "no"
        redirect_to minor_client_individual_path(@intake_form)
      else
        redirect_to root_path
      end
    else
      render :action => :personal
    end
  end
  
  def minor
    @intake_form = IntakeForm.find params[:id]
    @minor = Minor.new
    3.times{@minor.childrens.build}
  end
  
  def minor_information
    @intake_form = IntakeForm.find params[:id]
    @minor = Minor.new(params[:minor])
    @minor.intake_form_id = @intake_form.id
    @minor.client_id = current_user.id
    if @minor.save
      redirect_to medical_client_minor_path(@minor)
    else
      render :action => :minor
    end
  end
  
end

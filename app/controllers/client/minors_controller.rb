class Client::MinorsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  #minor intake form new
  def new
    @client = current_user
    @intake_type = params[:intake_type]
    @start_date = Date.today.beginning_of_week(start_day = :monday)
    @end_date = Date.today.beginning_of_week+5.days
    @minor = Minor.new
    3.times{@minor.childrens.build}
  end
  
  def create
    @client = current_user
    @intake_type = params[:minor][:intake_type]
    @start_date = Date.today.beginning_of_week(start_day = :monday)
    @end_date = Date.today.beginning_of_week+5.days
    @minor = Minor.new(params[:minor])
    @minor.client_id = @client.id
    if @minor.save
      @intake_form = IntakeForm.new(:user_id => @client.id,:intake_type => @intake_type,:intake_status => "processing")
      @intake_form.save
      @document = Document.new(:user_id => current_user.id,:client_id =>current_user.id,:intake_form_id => @intake_form.id,:doc_type => "intake_form")
      @document.save(:validate => false)
      if params[:times]
        params[:times].each do |tim|
          ClientAvailability.create(:start_at => tim.split(',')[0],:end_at => tim.split(',')[1],:client_id => current_user.id,:intake_form_id => @intake_form.id)
        end
      end
      @minor.update_attribute(:intake_form_id,@intake_form.id)
      redirect_to medical_client_minor_path(@minor)
    else
      render :action => :new
    end
  end
  
  def medical
    @client = current_user
    @minor = Minor.find params[:id]
    @medical = Medical.new
    1.times{@medical.medical_reasons.build}
    1.times{@medical.medications.build}
  end
  
  def medical_information
    @client = current_user
    @minor = Minor.find params[:id]
    @medical = Medical.new(params[:medical])
    @medical.minor_id = @minor.id
    @medical.intake_form_id = @minor.intake_form_id
    @medical.client_id = @client.id
    if @medical.save
      redirect_to personal_client_minor_path(@minor)
    else
      render :action => :medical
    end
  end
  
  def personal
    @minor = Minor.find params[:id]
    @personal = Personal.new
  end
  
  def personal_information
    @minor = Minor.find params[:id]
    @personal = Personal.new(params[:personal])
    @personal.minor_id = @minor.id
    @personal.intake_form_id = @minor.intake_form_id
    @personal.client_id = current_user.id
    @personal.client_id = current_user.id
    if @personal.save
      redirect_to root_path
    else
      render :action => :personal
    end
  end
  
end

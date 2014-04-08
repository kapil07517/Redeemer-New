class Client::IntakesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def index
    
  end
  
  def show
    @intake_form = IntakeForm.all_information(params[:id]).first
    if !@intake_form.medical_id.nil?
      @medical_reasons = MedicalReason.where("medical_id = '#{@intake_form.medical_id}'")
      @medications = Medication.where("medical_id = '#{@intake_form.medical_id}'")
    else
      @medical_reasons = []
      @medications = []
    end
  end
end

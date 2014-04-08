class IntakeCoordinator::DashboardsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user,:except => [:calendar]
  def index
    @cases = Case.where("counselor_id IS NULL")
  end
  
  def intake_details
    @case = Case.find params[:id]
    @intake_form = IntakeForm.all_information(@case.intake_form_id).first
    if !@intake_form.medical_id.nil?
      @medical_reasons = MedicalReason.where("medical_id = '#{@intake_form.medical_id}'")
      @medications = Medication.where("medical_id = '#{@intake_form.medical_id}'")
    else
      @medical_reasons = []
      @medications = []
    end
    render
  end
  
  def details
    @intake_form = IntakeForm.all_information(params[:id]).first
    if !@intake_form.medical_id.nil?
      @medical_reasons = MedicalReason.where("medical_id = '#{@intake_form.medical_id}'")
      @medications = Medication.where("medical_id = '#{@intake_form.medical_id}'")
    else
      @medical_reasons = []
      @medications = []
    end
    @client = User.find(@intake_form.user_id)
    @partners = @client.partners.where("intake_type = ?", @intake_form.intake_type)
    @intakes = []
    @partners.each do |int|
      @user = User.find_by_email(int.email)
      if @user
        @user.intake_forms.each do |i_form|
          @intakes<<[int.name,int.date_of_birth,@user.id,i_form.id]
        end
      end
    end
    render
  end
  
  def assign_case_counselor
    @case = Case.find(params[:case_in])
    @counselor = Counselor.find(params[:con]).id
    @appointment = Appointment.create(:counselor_id => @counselor,:case_id => @case.id, :status => params[:status])
    @case.update_attribute(:counselor_id,@counselor)
    CaseCounselor.create(:case_id => @case.id,:counselor_id => @counselor)
    render
  end
  
  def calendar
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @start_date = @date.beginning_of_week(:sunday).to_date
    @end_date = @date.end_of_week(:sunday).to_date
    @rooms = Room.all
    @counselors = Counselor.all
    @cases = Case.all
    @counselor_room = CounselorAvailability.new
    @counselor_availabilities = CounselorAvailability.where("start_at BETWEEN '#{@start_date} 00:01:01' and '#{@end_date} 23:59:59'")
    @common_appointments = Array.new
    @main_appoints = Array.new
    @counselor_availabilities.each do |a|
      @common_appointments << a.start_at.strftime("%Y-%m-%d %H:%M:%S")+a.room_id.to_s
      @main_appoints << a
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
end

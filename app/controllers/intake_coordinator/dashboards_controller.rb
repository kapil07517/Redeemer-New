class IntakeCoordinator::DashboardsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user,:except => [:next_calendar]
  def index
    @cases = Case.where("counselor_id IS NULL")
  end
  
  def intake_details
    @case = Case.find params[:id]
    @counselor = Counselor.find(params[:appointment])
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
    @appointment = Appointment.create(:client_id => @case.intake_form.user_id,:counselor_id => @counselor,:case_id => @case.id, :intake_form_id => @case.intake_form_id, :status => params[:status])
    @case.update_attribute(:counselor_id,@counselor)
    CaseCounselor.create(:case_id => @case.id,:counselor_id => @counselor)
    render
  end
  
  def calendar
    @date = Date.today
    @start_date = @date.beginning_of_week(:sunday).to_date
    @end_date = @date.end_of_week(:sunday).to_date
    @rooms = Room.all
    @counselors = Counselor.all
    @cases = Case.all
    @appointment = Appointment.new
    @appointments = Appointment.where("start_at BETWEEN '#{@start_date} 00:01:01' and '#{@end_date} 23:59:59'")
    @common_appointments = Array.new
    @main_appoints = Array.new
    @appointments.each do |a|
      @common_appointments << a.start_at.strftime("%Y-%m-%d %H:%M:%S")+a.room_id.to_s
      @main_appoints << a
    end
    
    #    @calendar_information = []
    #    (@start_date..@end_date).each do |da|
    #      (8..22).each do |i|
    #        @availabilities = ClientAvailability.where("start_at BETWEEN '#{da.to_s+' '+(i>9 ? i.to_s+':00:00' : '0'+i.to_s+':00:00')}' and '#{da.to_s+' '+(i>9 ? (i+1).to_s+':00:00' : '0'+(i+1).to_s+':00:00')}'")
    #        @availabilities.each do |avail|
    #          @calendar_information<<["#{da.to_s+' '+(i>9 ? i.to_s+':00:00' : '0'+i.to_s+':00:00')}",avail]
    #        end
    #      end
    #      
    #    end
    #    @appointments = CounselorAvailability.scoped
    #    respond_to do |format|
    #      format.html # index.html.erb
    #      format.json { render :json => @appointments.to_json }
    #    end
  end
  
  #counselor appointments through calendar /counselor/dashboards/counselor_status?params[:date]&params[:day]
  def next_calendar
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @start_date = @date.beginning_of_week(:sunday).to_date
    @end_date = @date.end_of_week(:sunday).to_date
    @day = params[:day].present? ? Date.parse(params[:day]).to_date : Date.today
    @rooms = Room.all
    @counselors = Counselor.all
    @cases = Case.all
    @appointment = Appointment.new
    @appointments = Appointment.where("start_at BETWEEN '#{@start_date} 00:01:01' and '#{@end_date} 23:59:59'")
    @common_appointments = Array.new
    @main_appoints = Array.new
    @appointments.each do |a|
      @common_appointments << a.start_at.strftime("%Y-%m-%d %H:%M:%S")+a.room_id.to_s
      @main_appoints << a
    end
    
    #    @appointments = current_user.appointments.where("start_at BETWEEN '#{@day} 00:01:01' AND '#{@day} 23:59:59'")
    #    @calendar_information = []
    #    (@start_date..@end_date).each do |da|
    #      (8..22).each do |i|
    #        @availabilities = Avalability.where("start_at = '#{da.to_s+' '+(i>9 ? i.to_s+':00:00' : '0'+i.to_s+':00:00')}'")
    #        @availabilities.each do |avail|
    #          @calendar_information<<["#{da.to_s+' '+(i>9 ? i.to_s+':00:00' : '0'+i.to_s+':00:00')}",avail]
    #        end
    #      end
    #    end
    respond_to do |format|
      format.js
    end
  end
end

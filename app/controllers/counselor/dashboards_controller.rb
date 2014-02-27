class Counselor::DashboardsController < ApplicationController
  before_filter :is_correct_user
  before_filter :is_login
  
  #counselor home page
  def home
    
  end

  #counselor appointments through calendar /counselor/dashboards/counselor_status?params[:date]&params[:day]
  def counselor_status
    @reminder = Reminder.new
    @reminders = Reminder.all
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @start_date = @date.beginning_of_week(:sunday).to_date
    @end_date = @date.end_of_week(:sunday).to_date
    @day = params[:day].present? ? (Date.parse(params[:day])).to_date : Date.today
    @appointments = current_user.appointments.where("start_at BETWEEN '#{@day} 00:01:01' AND '#{@day} 23:59:59'")
    #    @appointments = current_user.appointments
    respond_to do |format|
      format.js
    end
  end

  #counselor appointments through calendar /counselor/dashboards/counselor_status?params[:date]&params[:day]
  def counselor_down_status
    @date = params[:date].present? ? Date.parse(params[:date]) : Date.today
    @start_date = @date.beginning_of_week(:sunday).to_date
    @end_date = @date.end_of_week(:sunday).to_date
    @day = params[:day].present? ? Date.parse(params[:day]).to_date : Date.today
    @appointments = current_user.appointments.where("start_at BETWEEN '#{@day} 00:01:01' AND '#{@day} 23:59:59'")
    respond_to do |format|
      format.js
    end
  end
  
  #displaying the counselor appointments in calendar format
  def appointments
    @counselor = Counselor.find(current_user.id)
    @appointments = @counselor.counselor_availabilities.scoped
    @appointments = @counselor.counselor_availabilities.between(params['start'], params['end']) if (params['start'] && params['end'])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @appointments.to_json }
    end
  end
  
  def create_appointment
    @counselor = Counselor.find(current_user.id)
    @counselor_appointment = CounselorAvailability.new(params[:counselor_appointment])
    @counselor_appointment.counselor_id = @counselor.id
    @counselor_appointment.end_at = @counselor_appointment.start_at+1.hour
    @counselor_appointment.save
    @appointments = @counselor.counselor_availabilities.scoped
    @appointments = @counselor.counselor_availabilities.between(params['start'], params['end']) if (params['start'] && params['end'])
    respond_to do |format|
      format.js
    end
  end
  
  #counselor cases /counselor/dashboards/case_list
  def case_list
    if params[:query] and params[:query] != "all"
      @cases = Case.where("status = '#{params[:query]}'")
      case_ids = @cases.map{|a| a.id}
      @appointments = current_user.appointments.where("case_id IN (#{case_ids.empty? ? '0' : case_ids.split(",").join(",")})")
    else
      @appointments = current_user.appointments
    end
  end
  
  def client_list
    @appointments = current_user.appointments
  end
  
  def update_appointment
    @appointment = CounselorAvailability.find params[:id]
    @appointment.update_attributes(params[:appointment])
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end

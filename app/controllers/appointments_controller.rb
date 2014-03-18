class AppointmentsController < ApplicationController
  before_filter :is_login
  
  def new
    
  end
  
  def create
    @rooms = Room.all
    @counselors = Counselor.all
    @cases = Case.all
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      @date = @appointment.start_at
      @start_date = @date.beginning_of_week(:sunday).to_date
      @end_date = @date.end_of_week(:sunday).to_date
      @appointments = Appointment.where("start_at BETWEEN '#{@start_date} 00:01:01' and '#{@end_date} 23:59:59'")
      @common_appointments = Array.new
      @main_appoints = Array.new
      @appointments.each do |a|
        @common_appointments << a.start_at.strftime("%Y-%m-%d %H:%M:%S")+a.room_id.to_s
        @main_appoints << a
      end
    else
      render :new
    end
  end
  
  def edit
    @counselors = Counselor.all
    @cases = Case.all
    @appointment = Appointment.find(params[:id])
  end

  def update
    @counselors = Counselor.all
    @cases = Case.all
    @rooms = Room.all
    @appointment = Appointment.find(params[:id])
    if @appointment.update_attributes(params[:appointment])
      @date = @appointment.start_at
      @start_date = @date.beginning_of_week(:sunday).to_date
      @end_date = @date.end_of_week(:sunday).to_date
      @appointments = Appointment.where("start_at BETWEEN '#{@start_date} 00:01:01' and '#{@end_date} 23:59:59'")
      @common_appointments = Array.new
      @main_appoints = Array.new
      @appointments.each do |a|
        @common_appointments << a.start_at.strftime("%Y-%m-%d %H:%M:%S")+a.room_id.to_s
        @main_appoints << a
      end
    else
      render :edit
    end
  end  
  
end

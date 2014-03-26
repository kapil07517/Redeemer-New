class SchedulingsController < ApplicationController
  
  def new
    
  end
  
  def create
    @rooms = Room.all
    @counselors = Counselor.all
    @cases = Case.all
    @counselor_room = CounselorAvailability.new(params[:counselor_availability])
    if @counselor_room.save
      @date = @counselor_room.start_at
      @start_date = @date.beginning_of_week(:sunday).to_date
      @end_date = @date.end_of_week(:sunday).to_date
      @counselor_availabilities = CounselorAvailability.where("start_at BETWEEN '#{@start_date} 00:01:01' and '#{@end_date} 23:59:59'")
      @common_appointments = Array.new
      @main_appoints = Array.new
      @counselor_availabilities.each do |a|
        @common_appointments << a.start_at.strftime("%Y-%m-%d %H:%M:%S")+a.room_id.to_s
        @main_appoints << a
      end
    else
      render :new
    end
  end
end

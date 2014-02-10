class RemindersController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  
  def new
    @client = Client.find(params[:client_id])
    @reminder = Reminder.new
  end
  
  def create
    @reminder = Reminder.new(params[:reminder])
    @client = Client.find(@reminder.client_id) if params[:reminder][:client_id]
    @case = Case.find(@reminder.case_id) if params[:reminder][:case_id]
    if params[:counselor_home]
      @counselor_home = params[:counselor_home]
      @reminders = Reminder.where("case_id = #{@case.id} and client_id = #{@client.id}")
    end
    @reminder.save
    respond_to do |format|
      format.js
    end
  end
end

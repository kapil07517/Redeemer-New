class RemindersController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  
  def create
    @reminder = Reminder.new(params[:reminder])
    @client = Client.find(@reminder.client_id) if params[:reminder][:client_id]
    @case = Case.find(@reminder.case_id) if params[:reminder][:case_id]
    @reminder.save
    respond_to do |format|
      format.js
    end
  end
end

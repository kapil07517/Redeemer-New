class IntakeCoordinator::DashboardsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user  
  def index
    @cases = Case.where("counselor_id IS NULL")
  end
  
  def intake_details
    @case = Case.find params[:id]
    @counselor = Counselor.find(params[:appointment])
    @intake_form = IntakeForm.all_information(@case.intake_form_id).first
    render
  end
  
  def details
    @intake_form = IntakeForm.all_information(params[:id]).first
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
    render
  end
end

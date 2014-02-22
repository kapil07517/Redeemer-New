class CaseManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents.order("created_at desc")
    @document = Document.new
    @counselor_permission = CounselorPermission.find_by_case_id_and_counselor_id(@case.id,@case.counselor_id) if @case.counselor
    if @counselor_permission
      @permission = @counselor_permission.permission
    end
    session[:ap_id] = params[:appointment_id] if params[:appointment_id]
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    @account = @appointment.nil? ? PayerAccount.where("case_id = #{@case.id}").last : PayerAccount.where("case_id = #{@case.id} and client_id = #{@appointment.client.id}").last
    @authcounts = @appointment.nil? ? SessionPayment.where("case_id = #{@case.id}").count : SessionPayment.where("case_id = #{@case.id} and client_id = #{@appointment.client.id}").count
  end
  
  def upload_document
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents.order("created_at desc")
    @document = Document.new(params[:document])
    @appointment = Appointment.find(session[:ap_id]) if session[:ap_id]
    if @document.save
      redirect_to case_management_path(@case)
    else
      render :action => :show
    end
  end
  
  def counselor_permisson
    @counselor = Counselor.find(params[:counselor_id])
    @case = Case.find(params[:case_id])
    @counselor_permission = CounselorPermission.find_by_case_id_and_counselor_id(@case.id,@counselor.id)
    if @counselor_permission
      @counselor_permission.update_attribute(:permission,params[:permission])
    else
      CounselorPermission.create(:case_id => @case.id,:counselor_id => @counselor.id,:permission => params[:permission])
    end
    respond_to do |format|
      format.js { head :no_content }
    end
  end
end

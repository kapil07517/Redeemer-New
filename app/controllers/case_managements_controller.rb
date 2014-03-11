class CaseManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    @case = Case.find(params[:id])
    @reminder = Reminder.new
    @documents = @case.documents.order("created_at desc")
    @document = Document.new
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
    @case = Case.find(params[:case_id])
    params["counselors"].each do |coun|
      @counselor_permission = CounselorPermission.find_by_case_id_and_counselor_id(@case.id,coun)
      if @counselor_permission
        @counselor_permission.update_attribute(:permission,params[:permission])
      else
        CounselorPermission.create(:case_id => @case.id,:counselor_id => coun,:permission => params[:permission])
      end
    end
    respond_to do |format|
      format.js { head :no_content }
    end
  end
  
  def destroy
    @case_client = CaseClient.find(params[:id])
    @case = Case.find(@case_client.case_id)
    @client = @case_client.client.full_name
    @case_client.destroy
    @document = Document.new(:user_id => current_user.id,:case_id =>@case.id,:doc_type => "client_change",:description => "Client #{@client} was removed from Case #{@case.number} on #{Time.now.strftime('%m-%d-%Y')} by STAFF MEMBER #{current_user.full_name}")
    @document.save(:validate => false)
  end
  
  def remove_counselor
    @case_counselor = CaseCounselor.find(params[:id])
    @case = Case.find(@case_counselor.case_id)
    @counselor = @case_counselor.counselor.full_name
    @case_counselor.destroy
    @document = Document.new(:user_id => current_user.id,:case_id =>@case.id,:doc_type => "staff_change",:description => "Counselor #{@counselor} was removed from Case #{@case.number} on #{Time.now.strftime('%m-%d-%Y')} by STAFF MEMBER #{current_user.full_name}")
    @document.save(:validate => false)
  end
  
  def add_counselor
    @case = Case.find(params[:case_id])
    @counselor = Counselor.find(params[:counselor_id])
    @case_counselor = CaseCounselor.create(:case_id => @case.id,:counselor_id => @counselor.id)
    @counselor = @case_counselor.counselor.full_name
    @document = Document.new(:user_id => current_user.id,:case_id =>@case.id,:doc_type => "staff_change",:description => "Counselor #{@counselor} was removed from Case #{@case.number} on #{Time.now.strftime('%m-%d-%Y')} by STAFF MEMBER #{current_user.full_name}")
    @document.save(:validate => false)
  end
end

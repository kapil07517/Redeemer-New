class Counselor::InvoicesController < ApplicationController
  before_filter :is_correct_user
  
  def new
    @appointment = Appointment.find(params[:appointment_id])
    @client = Client.find(params[:client_id])
    @case = Case.find(@appointment.case_id)
    @reminders = Reminder.where("case_id = #{@case.id} and client_id = #{@client.id}")
    @reminder= Reminder.new
    @invoice = SessionPayment.new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @invoice = SessionPayment.new(params[:session_payment])
    @appointment = Appointment.find(params[:session_payment][:appointment_id])
    @client = Client.find(@appointment.client_id)
    @invoice.case_id = @appointment.case_id
    @invoice.client_id = @client.id
    @reminders = Reminder.where("case_id = #{@appointment.case_id} and client_id = #{@appointment.client_id}")
    @reminder= Reminder.new
    respond_to do |format|
      if @invoice.save
        if params[:commit] == 'EMAIL RECEIPT'
          NotifierMailer.email_invoice_details(@invoice,@invoice.client).deliver
        end
        format.js
      else
        format.js{render :action => 'new'}
      end
    end
  end
  
  def update
    @invoice = SessionPayment.find(params[:id])
    @appointment = Appointment.find(params[:session_payment][:appointment_id])
    respond_to do |format|
      @invoice.update_attributes(params[:session_payment])
      if params[:commit] == 'EMAIL RECEIPT'
        NotifierMailer.email_invoice_details(@invoice,@invoice.client).deliver
      end
      format.js
    end
  end
  
  def update_values
    @uos = params[:id].to_i
    @fees = params[:fees].to_i
    @copay = @fees * @uos
    @owes = @copay
  end
end

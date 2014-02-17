class Counselor::InvoicesController < ApplicationController
  before_filter :is_correct_user
  
  def new
    @appointment = Appointment.find(params[:appointment_id])
    @client = Client.find(params[:client_id])
    @case = Case.find(@appointment.case_id)
    @reminders = Reminder.where("case_id = #{@case.id} and client_id = #{@client.id}")
    @acc = PayerAccount.where("case_id = #{@case.id} and client_id = #{@client.id}").last
    @fee = SessionFee.where("case_id = #{@case.id}").last
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
        if @invoice.session_status == "missed_unbillable"
          balance =  @invoice.fees
        else
        end
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
    @payer_amt = params[:payer_amt].to_i if @payer_amt.blank?
    if !@payer_amt.blank?
      @copay = @fees * @uos - @payer_amt * @uos
    else
      @copay = @fees * @uos
    end
    @owes = @copay
  end
end

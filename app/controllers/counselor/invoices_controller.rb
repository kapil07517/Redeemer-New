class Counselor::InvoicesController < ApplicationController
  before_filter :is_correct_user
  
  def new
    @appointment = Appointment.find(params[:appointment_id])
    @case = Case.find(@appointment.case_id)
    @reminders = Reminder.where("case_id = #{@case.id} and hidden = #{false}")
    @acc = PayerAccount.where("case_id = #{@case.id}").last
    @fee = SessionFee.where("case_id = #{@case.id}").last
    @authcounts = SessionPayment.where("case_id = #{@case.id}").count
    @session_payment = SessionPayment.where("case_id = #{@case.id}").last
    @reminder= Reminder.new
    @invoice = SessionPayment.new(params[:session_payment])
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @invoice = SessionPayment.new(params[:session_payment])
    @appointment = Appointment.find(params[:session_payment][:appointment_id])
    @invoice.case_id = @appointment.case_id
    @reminders = Reminder.where("case_id = #{@appointment.case_id} and client_id = #{@appointment.client_id} and hidden = #{false}")
    @reminder= Reminder.new
    respond_to do |format|
      if @invoice.save
        if @invoice.session_status == "completed"
          balance =  @invoice.fee.to_f - @invoice.amount.to_f
        else
          balance =  @invoice.fee.to_f
        end
        @invoice.update_attribute(:balance, balance)
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
    @payer_amt = params[:payer_amt].to_i 
    @balance = params[:balance].to_i
    @copay = @fees * @uos - @payer_amt * @uos
    @owes = @copay + @balance
  end
end

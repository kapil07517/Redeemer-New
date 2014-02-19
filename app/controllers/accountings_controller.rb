class AccountingsController < ApplicationController
  
  def new
    @case = Case.find(params[:case_id]) if params[:case_id]
    @client = Client.find(params[:client_id]) if params[:client_id]
    @session_payments = @case.session_payments if @case
    @session_payments = @client.session_payments if @client
    @session = SessionPayment.new
    @m_payment = MiscellaneousPayment.new
    @payer_account = PayerAccount.new
    @session_fee = SessionFee.new
  end
  
  def create
    @session = SessionPayment.new(params[:session_payment])
    @session.client_id = @session.payment_name.split(",").last if @session.payment_name and @session.payment_name.split(",").first == "Client"
    @session.payer_id = @session.payment_name.split(",").last if @session.payment_name and @session.payment_name.split(",").first == "Payer"
    if @session.valid?
    else
      
    end
    render
  end
  
  def update
    @session = SessionPayment.find(params[:id])
    @session.client_id = params[:session_payment][:payment_name].split(",").last if params[:session_payment][:payment_name] and params[:session_payment][:payment_name].split(",").first == "Client"
    @session.payer_id = params[:session_payment][:payment_name].split(",").last if params[:session_payment][:payment_name] and params[:session_payment][:payment_name].split(",").first == "Payer"
    unless @session.session_status == "completed"
      @session.balance = @session.fee - params[:amount].to_i
    end
    @session.update_attributes(params[:session_payment])
  end
  
  def m_payment
    @m_payment = MiscellaneousPayment.new(params[:miscellaneous_payment])
    @client = Client.find(@m_payment.client_id) if !@m_payment.client_id.blank?
    @case = Case.find(@m_payment.case_id) if !@m_payment.case_id.blank?
    if @m_payment.save
    else
    end
    render
  end
  
  def payer_account
    @payer_account = PayerAccount.new(params[:payer_account])
    @payer_account.save
    render
  end
  
  def session_fee
    @session_fee = SessionFee.new(params[:session_fee])
    @session_fee.save
  end
  
  def update_session_payment
    @session = SessionPayment.find(params[:id])
  end
end

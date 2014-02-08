class AccountingsController < ApplicationController
  
  def new
    @case = Case.find(params[:case_id]) if params[:case_id]
    @client = Client.find(params[:client_id]) if params[:client_id]
    @session_payments = @case.session_payments if @case
    @session_payments = @client.session_payments if @client
    @session = SessionPayment.new
    @m_payment = MiscellaneousPayment.new
  end
  
  def create
    @session = SessionPayment.new(params[:session_payment])
    if @session.save
    else
      
    end
    render
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
end

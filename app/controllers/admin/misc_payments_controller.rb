class Admin::MiscPaymentsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @misc_payment = MiscPayment.new
  end
  
  def create
    @misc_payment = MiscPayment.new(params[:misc_payment])
    if @misc_payment.save
      flash[:notice] = "Misc Payments saved succesfully"
      redirect_to new_admin_misc_payment_path
    else
      render :action => :new
    end
  end
end

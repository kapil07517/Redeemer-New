class Client::ReducedFeesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user,:except => [:show]
  def new
    @reduced_fee = ReducedFee.new
    2.times{@reduced_fee.dependents.build}
  end
  
  def create
    @reduced_fee = ReducedFee.new(params[:reduced_fee])
    @reduced_fee.client_id = current_user.id
    if current_user.valid_password?(params[:reduced_fee][:doc_password])
      if @reduced_fee.save
        @document = Document.new(:client_id =>current_user.id,:reduced_fee_id => @reduced_fee.id,:doc_type => "reduced_fee")
        @document.save(:validate => false)
        redirect_to root_path
      else
        render :action => :new
      end
    else
      @reduced_fee.errors.add(:doc_password,'Entered password is wrong.Please try again!')
      render :action => :new
    end
  end
  
  #displaying reduced form details 
  def show
    @reduced_fee = ReducedFee.find(params[:id])
  end
  
end

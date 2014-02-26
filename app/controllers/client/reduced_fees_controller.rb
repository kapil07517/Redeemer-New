class Client::ReducedFeesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @reduced_fee = ReducedFee.new
    2.times{@reduced_fee.dependents.build}
  end
  
  def create
    @reduced_fee = ReducedFee.new(params[:reduced_fee])
    @reduced_fee.client_id = current_user.id
    if @reduced_fee.save
      @document = Document.new(:client_id =>current_user.id,:reduced_fee_id => @reduced_fee.id,:doc_type => "reduced_fee")
      @document.save(:validate => false)
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
end

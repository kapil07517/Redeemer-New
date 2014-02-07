class Admin::PayersController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @payer = Payer.new
  end
  
  def create
    @payer = Payer.new(params[:payer])
    if @payer.save
      flash[:notice] = "Payer saved succesfully"
      redirect_to admin_payers_path(:role => "Info")
    else
      render :action => :new
    end
  end
  
  def index
    @payers = Payer.all
  end
  
  def search_payers
    @payers = Payer.where("name_of_org LIKE '%#{params[:search]}%'")
  end
end

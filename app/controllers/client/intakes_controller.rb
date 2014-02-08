class Client::IntakesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def index
    
  end
  
  def show
    @intake_form = IntakeForm.all_information(params[:id]).first
  end
end

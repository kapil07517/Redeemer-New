class Client::IntakesController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def index
    
  end
end

class HomeController < ApplicationController
  before_filter :get_user
  
  def index
    
  end
  
  private
  def get_user
    if current_user and current_user.role != 'admin'
      redirect_to "/"+current_user.role+"/dashboards"
    elsif current_user and current_user.role == 'admin'
      redirect_to "/"+current_user.role+"/case_prefixes"
    end
  end
end

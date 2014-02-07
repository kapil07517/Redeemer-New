class HomeController < ApplicationController
  before_filter :get_user
  
  def index
    
  end
  
  private
  def get_user
    if current_user
        redirect_to "/"+current_user.role+"/dashboards"
    end
  end
end

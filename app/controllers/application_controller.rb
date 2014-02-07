class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  before_filter :authenticate unless Rails.env == 'development'
  layout :layout
  
  def layout
    if current_user and current_user.role == 'counselor'
      'counselor'
    elsif current_user and current_user.role == 'intake_coordinator'
      "intake_coordinator"
    elsif current_user and current_user.role == 'admin'
      "admin"
    else
      "application"
    end
  end
  
  #after registering an account it will redirect to home page /home
  def after_sign_up_path_for(resource)
    if resource.is_a?(User)
      root_path
    end
  end

  #redirect after sign in
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      flash[:notice] = "Successfully Login!"
      if resource_or_scope.role == "admin"
        "/admin/case_prefixes"
      else
        "/"+resource_or_scope.role+"/dashboards"
      end
    end
  end
  
  #checking the details before redirecting to dashboard if the user is client
  def fill_full_information
    unless current_user and (!current_user.middle_initial.blank? or !current_user.address.blank? or !current_user.contact_name.blank?)
      redirect_to edit_setting_path(:role => current_user.role,:id => current_user.id)
    end
  end
  
  #if current_user and his role is not assigned for the particular task it will take to /home
  def is_correct_user
    unless current_user and current_user.role == request.fullpath.split("/").delete_if(&:empty?)[0]
      flash[:error] = 'Please login!'
      redirect_to root_path
    end
  end 
  
  #first comes to here and checks the user is login user or not
  def is_login
    unless current_user
      flash[:error] = 'Please Login!'
      redirect_to root_path
    end
  end
  
  #if not current_user and his role is not in admin or counselor it will take to /home
  def is_intake_coordinator_or_counselor
    unless current_user and ['intake_coordinator','counselor'].include?(current_user.role)
      flash[:error] = "You don't have permissions!"
      redirect_to root_path
    end
  end
  
  protected

  #http authentication for production site
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "rcms-develop" && password == "rcmsdevelop"
    end
  end
end

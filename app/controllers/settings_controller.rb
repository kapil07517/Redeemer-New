class SettingsController < ApplicationController
  before_filter :is_login
  before_filter :fill_full_information,:except => ['edit','update','change_password','update_password']
  #edit form for user to edit their information /:role/settings/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  #updating user information /:role/settings/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params["#{@user.role}"])
      flash[:notice] = 'Updated Sussessfully!'
      redirect_to @user.role == 'client' ? "/"+@user.role+"/intakes" : '/'
    else
      puts @user.errors.inspect
      render :action => :edit
    end
  end
  
  #settings for current user to change his password /:role/settings/:id/setting
  def change_password
    @user = current_user
  end

  #updating the password of the current user /:role/settings/:id/update_settings
  def update_password
    @user = current_user
    current_user.errors.add(:current_password,'is required') if params["#{@user.role}"].nil? or params["#{@user.role}"][:current_password].to_s.blank?
    if current_user.errors.empty? and current_user.update_with_password(params["#{@user.role}"])
      if current_user.role != 'counselor'
        flash[:notice] = 'Your password changed successfully!'
      else
        flash[:notice] = 'Your account information updated successfully !'
      end
      sign_in(@user, :bypass => true)
      redirect_to "/"+@user.role+"/dashboards"
    else
      render :action => :change_password
    end
  end
  
end

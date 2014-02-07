class Admin::UsersController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  #new form for creating users /admin/users/new
  def new
    @user = User.new
    @role = params[:role]
  end

  #create a record for user in table /admin/users/
  def create
    @role = params[:user][:type]
    @user = User.new(params[:user].merge(:role =>params[:user][:type].blank? ? '':(params[:user][:type].split(/([[:upper:]][[:lower:]]*)/).delete_if(&:empty?).join("_").downcase)))
    if @user.save
      flash[:notice] = 'Created Successfully!'
      redirect_to admin_users_path
    else
      render :action => 'new'
    end
  end
  #edit form if user /admin/users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  #updating user details /admin/users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params["#{@user.role}"].merge(:role =>params["#{@user.role}"][:type].blank? ? '':(params["#{@user.role}"][:type].split(/([[:upper:]][[:lower:]]*)/).delete_if(&:empty?).join("_").downcase)))
      flash[:notice] = 'Updated Successfully!'
      redirect_to admin_users_path
    else
      puts @user.errors.inspect
      flash[:error] = 'Updation Failed!'
      render :action => 'edit'
    end
  end

  #Deleting the existing user /admin/users/:id
  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
  end

  #displaying user details /admin/users/:id
  def show
    @client = User.find(params[:id])
    if @client.role == 'client'
      @cases = CaseCounselorClient.where("client_id = '#{@client.id}'")
      @appointments = @client.appointments.scoped
      @appointments = @client.appointments.between(params['start'], params['end']) if (params['start'] && params['end'])
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @appointments.to_json }
      end
    else
      redirect_to admin_dashboards_path
    end
  end
  
  def index
    @users = User.where("role != 'admin' and role != 'client'")
  end
  
  def clients
    @clients = User.where("role = 'client'")
  end
  
  def search_clients
    @clients = User.where("role = 'client' and (first_name LIKE '%#{params[:search]}%' or last_name LIKE '%#{params[:search]}%')")
  end
  
  def change_status
    @user = User.find(params[:id])
    @user.update_attribute(:status, params[:status])
  end
end

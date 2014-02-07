class Client::PartnersController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def new
    @client = current_user
    @intake_type = params[:intake_type]
    @partner = Partner.new
  end
  
  def create
    @client = current_user
    @intake_type = params[:partner][:intake_type]
    @partner = Partner.new(params[:partner])
    @partner.client_id = @client.id
    @partner.intake_type = @intake_type
    if @partner.save
      redirect_to new_client_individual_path(:intake_type => @intake_type)
    else
      render :action => :new
    end
  end
  
  def partners_family
    @client = current_user
    @intake_type = params[:intake_type]
    @partner = Partner.new
  end
  
  def partners_family_create
    @client = current_user
    @intake_type = params[:partner][:intake_type]
    params[:partners].each do |partner|
      @partner = Partner.new(:name => partner["name"],:date_of_birth => partner["date_of_birth"]["(1i)"] + "-" + partner["date_of_birth"]["(2i)"] + "-" + partner["date_of_birth"]["(3i)"],:email => partner["email"])
      @partner.client_id = @client.id
      @partner.intake_type = @intake_type
      @partner.save(:validate => false) if !partner["email"].blank?
    end
    session[:is_minor] = params[:partner][:is_minor]
    redirect_to new_client_individual_path(:intake_type => @intake_type)
  end
end
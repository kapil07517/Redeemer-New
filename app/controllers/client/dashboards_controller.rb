class Client::DashboardsController < ApplicationController
  before_filter :is_login
  before_filter :fill_full_information
  before_filter :is_correct_user
  def index
    @client = current_user
    @intake_forms = @client.intake_forms
  end
end

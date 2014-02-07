class Admin::DashboardsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
end

class Counselor::DashboardsController < ApplicationController
  before_filter :is_correct_user
  before_filter :is_login
end

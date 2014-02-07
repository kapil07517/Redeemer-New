class Client::RenewalGroupsController < ApplicationController
  before_filter :is_login
  before_filter :is_correct_user
  def index
    @renewal_groups = RenewalGroup.all
  end
end

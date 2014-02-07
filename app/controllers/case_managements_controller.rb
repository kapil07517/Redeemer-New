class CaseManagementsController < ApplicationController
  before_filter :is_intake_coordinator_or_counselor
  def show
    
  end
end

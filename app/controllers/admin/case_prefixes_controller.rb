class Admin::CasePrefixesController < ApplicationController
  before_filter :is_login
  before_filter :get_case_prefixies, :only => ["edit", "index", "update"]
  before_filter :is_correct_user
  
  def index
    @case_prefix = CasePrefix.new
  end
  
  def new
    @case_prefix = CasePrefix.new
  end
  
  def create
    @case_prefix = CasePrefix.new(params[:case_prefix])
    @case_prefix.save
    @case_prefixes = CasePrefix.all
    respond_to do |format|
      format.js
    end  
  end
  
  def edit
    @case_prefix = CasePrefix.find(params[:id])
  end
  
  def destroy
    @case_prefix = CasePrefix.find(params[:id])
    @case_prefix.destroy

    respond_to do |format|
      format.js
    end
  end

  def update
    @case_prefix = CasePrefix.find(params[:id])
    @case_prefix.update_attributes(params[:case_prefix])
    respond_to do |format|
      format.js
    end
  end
  
  private
  def get_case_prefixies
    @case_prefixes = CasePrefix.all
  end
end

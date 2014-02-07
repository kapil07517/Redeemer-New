class Admin::CptCodesController < ApplicationController
  before_filter :is_login
  before_filter :get_cpt_codes, :only => ["edit", "index", "update"]
  before_filter :is_correct_user
  
  def index
    @cpt_code = CptCode.new
  end
  
  def new
    @cpt_code = CptCode.new
  end
  
  def create
    @cpt_code = CptCode.new(params[:cpt_code])
    @cpt_code.save
    @cpt_codes = CptCode.all
    respond_to do |format|
      format.js
    end  
  end
  
  def edit
    @cpt_code = CptCode.find(params[:id])
  end
  
  def destroy
    @cpt_code = CptCode.find(params[:id])
    @cpt_code.destroy

    respond_to do |format|
      format.js
    end
  end

  def update
    @cpt_code = CptCode.find(params[:id])
    @cpt_code.update_attributes(params[:cpt_code])
    respond_to do |format|
      format.js
    end
  end
  
  private
  def get_cpt_codes
    @cpt_codes = CptCode.all
  end
end

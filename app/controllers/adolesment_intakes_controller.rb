class AdolesmentIntakesController < ApplicationController
  def new
    @case = Case.find(params[:case_id])
    @client = @case.intake_form.user
    @adolesment_intake = AdolesmentIntake.new
  end
  
  def create
    @case = Case.find(params[:adolesment_intake][:case_id])
    @client = @case.intake_form.user
    @adolesment_intake = AdolesmentIntake.new(params[:adolesment_intake])
    if @adolesment_intake.save
      @document = Document.new(:user_id => current_user.id,:case_id =>@case.id,:client_id =>@client.id,:adolesment_intake_id => @adolesment_intake.id,:doc_type => "adolesment_intake")
      @document.save(:validate => false)
      redirect_to edit_adolesment_intake_path(current_user.role,@adolesment_intake)
    else
      render :action => :new
    end
  end
  
  def client_adolesment_intake
    @client = Client.find(params[:id])
    @adolesment_intake = AdolesmentIntake.new
  end
  
  def client_adolesment
    @client = Client.find(params[:adolesment_intake][:client_id])
    @adolesment_intake = AdolesmentIntake.new(params[:adolesment_intake])
    if @adolesment_intake.save
      @document = Document.new(:user_id => current_user.id,:client_id =>@client.id,:adolesment_intake_id => @adolesment_intake.id,:doc_type => "adolesment_intake")
      @document.save(:validate => false)
      redirect_to edit_adolesment_intake_path(current_user.role,@adolesment_intake)
    else
      render :action => :client_adolesment_intake
    end
  end
  
  def edit
    @adolesment_intake = AdolesmentIntake.find(params[:id])
  end
  
  def update
    @adolesment_intake = AdolesmentIntake.find(params[:id])
    if @adolesment_intake.update_attributes(params[:adolesment_intake])
      redirect_to edit_adolesment_intake_path(current_user.role,@adolesment_intake)
    else
      render :action => :edit
    end
  end
end

class DischargeSummaryController < ApplicationController
  def new
    @case = Case.find(params[:case_id])
    @client = @case.intake_form.user
    @discharge_summary = DischargeSummary.new
  end
  
  def create
    @case = Case.find(params[:discharge_summary][:case_id])
    @client = @case.intake_form.user
    @discharge_summary = DischargeSummary.new(params[:discharge_summary])
    if @discharge_summary.save
      @document = Document.new(:case_id =>@case.id,:client_id =>@client.id,:discharge_summary_id => @discharge_summary.id,:doc_type => "discharge_summary")
      @document.save(:validate => false)
      redirect_to edit_discharge_summary_path(current_user.role,@discharge_summary)
    else
      render :action => :new
    end
  end
  
  def edit
    @discharge_summary = DischargeSummary.find(params[:id])
  end
  
  def update
    @discharge_summary = DischargeSummary.find(params[:id])
    if @discharge_summary.update_attributes(params[:discharge_summary])
      redirect_to edit_discharge_summary_path(current_user.role,@discharge_summary)
    else
      render :action => :edit
    end
  end
end

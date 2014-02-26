class Counselor::ProgressNotesController < ApplicationController
  
  def index
    @appointment = Appointment.find(params[:appointment_id])
    appoint_ids = []
    @appointment.case.appointments.each do |app|
      appoint_ids<<app.id
    end
    @progress_notes = ProgressNote.where("appointment_id IN (#{appoint_ids.split(",").join(",")})")
    if @appointment.progress_note and @appointment.progress_note.is_draft == true
      @is_draft = true
      @progress_note = ProgressNote.find(@appointment.progress_note.id)
    else
      @progress_note = ProgressNote.new
    end
  end
  
  def new
    @invoice = SessionPayment.find(params[:invoice_id])
    @appointment = Appointment.find(@invoice.appointment_id)
    appoint_ids = []
    @appointment.case.appointments.each do |app|
      appoint_ids<<app.id
    end
    @progress_notes = ProgressNote.where("appointment_id IN (#{appoint_ids.split(",").join(",")})")
    @progress_note = ProgressNote.new
  end
  
  def appointment_progress
    @appointment = Appointment.find(params[:progress_note][:appointment_id])
    appoint_ids = []
    @appointment.case.appointments.each do |app|
      appoint_ids<<app.id
    end
    @progress_notes = ProgressNote.where("appointment_id IN (#{appoint_ids.split(",").join(",")})")
    @progress_note = ProgressNote.new(params[:progress_note])
    @progress_note.counselor_id = current_user.id
    params[:commit] == 'Save to Draft' ? (@progress_note.is_draft = true):(@progress_note.is_draft = false)
    respond_to do |format|
      if @progress_note.save
        @document = Document.new(:case_id =>@appointment.case_id,:client_id =>@appointment.client_id,:progress_note_id => @progress_note.id,:doc_type => "progress_note")
        @document.save(:validate => false)
      else
      end
      format.js
    end
  end
  
  def create
    @appointment = Appointment.find(params[:progress_note][:appointment_id])
    appoint_ids = []
    @appointment.case.appointments.each do |app|
      appoint_ids<<app.id
    end
    @progress_notes = ProgressNote.where("appointment_id IN (#{appoint_ids.split(",").join(",")})")
    @progress_note = ProgressNote.new(params[:progress_note])
    @progress_note.counselor_id = current_user.id
    params[:commit] == 'Save to Draft' ? (@progress_note.is_draft = true):(@progress_note.is_draft = false)
    if @progress_note.save
      @document = Document.new(:case_id =>@appointment.case_id,:client_id =>@appointment.client_id,:progress_note_id => @progress_note.id,:doc_type => "progress_note")
      @document.save(:validate => false)
    else
      render :action => :index
    end
  end
  
  #updating the existing progress note record /counselor/progress_notes/:id
  def update
    @appointment = Appointment.find(params[:progress_note][:appointment_id])
    @progress_note = ProgressNote.find(params[:id])
    params[:commit] == 'Save to Draft' ? (@progress_note.is_draft = true):(@progress_note.is_draft = false)
    respond_to do |format|
      if @progress_note.update_attributes(params[:progress_note])
        format.js
      else
        params[:commit] == 'Save to Draft' ?  @is_draft = true : ""
        format.js
      end
    end
  end
  
  def edit
    @progress_note = ProgressNote.find(params[:id])
    @appointment = Appointment.find(@progress_note.appointment_id)
    appoint_ids = []
    @appointment.case.appointments.each do |app|
      appoint_ids<<app.id
    end
    @progress_notes = ProgressNote.where("appointment_id IN (#{appoint_ids.split(",").join(",")})")
  end
  
  def show
    @progress_note = ProgressNote.find(params[:id])
  end
  
  def destroy
    @progress_note = ProgressNote.find(params[:id])
    if @progress_note.destroy
      flash[:notice] = "Progress Note deleted successfully!"
    else
      flash[:error] = "Progress deletion failed!"
    end
    redirect_to root_path
  end
end

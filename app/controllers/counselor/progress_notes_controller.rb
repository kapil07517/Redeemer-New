class Counselor::ProgressNotesController < ApplicationController
  
  def index
    @appointment = Appointment.find(params[:appointment_id])
    if @appointment.progress_note and @appointment.progress_note.is_draft == true
      @is_draft = true
      @progress_note = ProgressNote.find(@appointment.progress_note.id)
    else
      @progress_note = ProgressNote.new
    end
  end
  
  def create
    @appointment = Appointment.find(params[:progress_note][:appointment_id])
    @progress_note = ProgressNote.new(params[:progress_note])
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
  end
  
  def show
    @progress_note = ProgressNote.find(params[:id])
  end
end

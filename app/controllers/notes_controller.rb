class NotesController < ApplicationController
  def create
    @note = Note.new(params[:note])
    @note.save
  end
end

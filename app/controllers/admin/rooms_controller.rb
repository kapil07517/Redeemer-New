class Admin::RoomsController < ApplicationController
  before_filter :is_login
  before_filter :get_rooms, :only => ["edit", "index", "update"]
  before_filter :is_correct_user
  
  def index
    @room = Room.new
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(params[:room])
    @room.save
    @rooms = Room.all
    respond_to do |format|
      format.js
    end  
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    respond_to do |format|
      format.js
    end
  end

  def update
    @room = Room.find(params[:id])
    @room.update_attributes(params[:room])
    respond_to do |format|
      format.js
    end
  end
  
  def change_status
    @room = Room.find(params[:id])
    @room.update_attributes(:status => params[:room_status])
  end
  
  private
  def get_rooms
    @rooms = Room.all
  end
end

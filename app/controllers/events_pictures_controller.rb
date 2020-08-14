class EventsPicturesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @event.event_picture.attach(params[:event_picture])
    flash[:success] = "L'image liée à votre event a bien été ajoutée"
    redirect_to :controller => 'events', :action => 'show', id: @event.id
  end

end

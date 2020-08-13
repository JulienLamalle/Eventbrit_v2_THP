class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :update, :destroy]
  attr_reader :events

  def index
    @events = Event.all 
  end

  def new
    @event = Event.new
  end

  def show 
    @event = Event.find(params[:id])
    @participants = Attendance.where(:event_id => @event.id)
    @admin =  @admin = User.find(@event.admin_id)
  end

  def create
    @event = Event.new(event_params)
    @event.admin_id = current_user.id

    if @event.save 
      flash[:success] = "Vous avez bien créé un event"
      redirect_to :controller => 'events', :action => 'show', id: @event.id
    else
      flash[:danger] = "Nous n'avons pas réussi à créer l'event pour la (ou les) raison(s) suivante(s) : #{@event.errors.full_messages.each {| message | message}.join(' , ')}"
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = "Merci #{@event.admin.first_name} ! Nous avons pu modifier l'event : #{@event.title} "
      redirect_to :controller => 'events', :action => 'show', id: @event.id
    else
      flash[:danger] = "Nous n'avons pas réussi à modifier l'event"
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:success] = "Merci #{@event.admin.first_name} ! Nous avons pu supprimer l'event : #{@event.title} "
      redirect_to :controller => 'events', :action => 'index' 
    else
      flash[:danger] = "Nous n'avons pas réussi à suppimer l'event ! "
      render :action => 'edit'
    end
  end


  private

  def event_params
    params.require(:event).permit(:title, :location, :start_date, :duration, :price, :description)
  end
end




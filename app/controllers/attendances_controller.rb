class AttendancesController < ApplicationController
  before_action :get_current_event
  attr_accessor :user, :event

  def index
    @participants = Array.new
    User.where(id: Attendance.where(event: @event).each {|attendance| @participants << User.find(attendance.participant_id) })
  end

  def new
    create
  end

  def create
    @attendance = Attendance.new(participant_id: current_user.id, stripe_customer_id: params[:token], event: Event.find(params[:event]))

    if @attendance.save 
      flash[:success] = "Vous participerez bien à cet event suite à votre paiement de #{Event.find(params[:event]).price} €"
      redirect_to :controller => 'events', :action => 'show', id: Event.find(params[:event]).id
    else
      flash[:danger] = "Nous n'avons pas réussi à créer votre particpation pour l'event"
      redirect_to controller: "events", :action => 'index'
    end
  end

  private

    def set_attendance
      @attendance = Attendance.find(params[:id])
    end
    
    def get_current_event
      @event = Event.where(params[id: :event_id])
    end

end

class AttendancesController < ApplicationController
  #before_action :set_attendance, only: [:new, :create, :index, :destroy]
  

  def index

    @event = Event.find(params[:event_id])
    @admin = User.find(@event.admin_id)
  end

  def new
    create
  end


  def create
    @attendance = Attendance.new(participant_id: current_user.id, stripe_customer_id: params[:token], event: Event.find(params[:event]))

    if @attendance.save 
      flash[:success] = "Vous participerez bien à cet event"
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

end

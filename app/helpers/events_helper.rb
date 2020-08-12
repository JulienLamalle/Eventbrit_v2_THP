module EventsHelper
  def end_date(event)
    @event = Event.find(params[:id])
    @event.start_date + @event.duration*60
  end

  def is_owner?(id)
    if current_user.id == id
      return true
    else
      return false
    end
  end
end

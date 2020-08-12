module AttendancesHelper

  def already_present?(event)
    Attendance.where(participant_id: current_user.id, event_id: event.id).size > 0
  end
end

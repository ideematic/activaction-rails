class AttendancesController < ApplicationController

  def create
    @event = Event.find(attendance_params[:event_id])
    current_user.attend_event(@event)
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  def destroy
    @event = Event.find(attendance_params[:event_id])
    Attendance.where(user_id: current_user.id, event_id: @event.id).destroy_all
    respond_to do |format|
      format.html { render layout: false }
    end
  end

  private
  def attendance_params
    params.permit(:event_id)
  end
end

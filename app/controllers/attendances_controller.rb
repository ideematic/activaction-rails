class AttendancesController < ApplicationController

  before_filter :authenticate_user!

  def create
    @event = Event.find(attendance_params[:event_id])
    current_user.attend_event(@event)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(attendance_params[:event_id])
    Attendance.where(user_id: current_user.id, event_id: @event.id).destroy_all
    redirect_to event_path(@event)
  end

  private
  def attendance_params
    params.permit(:event_id)
  end
end

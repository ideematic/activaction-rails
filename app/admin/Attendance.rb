ActiveAdmin.register Attendance do
  permit_params :user_id, :event_id, :status
end

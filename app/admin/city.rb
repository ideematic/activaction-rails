ActiveAdmin.register City do
  permit_params :name, :priority, :user_id
end

ActiveAdmin.register Event do
  permit_params :user_id, :category_id, :name, :date, :description, :text, :picture, :spots
end

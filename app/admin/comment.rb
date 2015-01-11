ActiveAdmin.register Comment, as: 'Comments' do
  permit_params :content, :commentable_id, :commentable_type, :user_id
end

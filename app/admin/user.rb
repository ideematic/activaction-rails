ActiveAdmin.register User do
  permit_params :id, :email, :password, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
                :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at, :first_name, :last_name,
                :gender, :bio, :username, :terms_at, :newsletter_at, :is_admin, :city_id, :birthdate, :studies,
                :desired_job, :professional_experiences, :education
end

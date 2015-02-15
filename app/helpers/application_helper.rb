module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def admin?
    current_user && current_user.is_admin
  end

  def own_profile?(user)
    current_user && current_user.id == user.id
  end

  def form_state(where, section)
    where.to_s == section.to_s ? 'form-state-editing' : 'form-state-static'
  end
end

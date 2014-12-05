module AttendancesHelper
  def attending_class
    {false => 'default', true => 'success', nil => 'default'}[current_user && current_user.attending_to?(@event)]
  end

  def attending_icon
    {pending: 'fa-ellipsis-h',
     accepted: 'fa-check',
     refused: 'fa-times',
     nil => 'fa-arrow-down'
    }.with_indifferent_access[current_user && current_user.attending_status(@event)]
  end

  def attending_text
    {pending: 'En attente',
     accepted: 'Participation acceptée',
     refused: 'Participation refusée',
     nil => 'Rejoindre'
    }.with_indifferent_access[current_user && current_user.attending_status(@event)]
  end
end

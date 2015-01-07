module AttendancesHelper
  def attending_class
    {nil => 'default',
     pending: 'success',
     refused: 'grey',
     admin: 'grey disabled'
    }.with_indifferent_access[current_user && current_user.attending_status(@event)]
  end

  def attending_icon
    {pending: 'fa-check', # fa-ellipsis-h
     accepted: 'fa-check',
     refused: 'fa-times',
     nil => 'fa-arrow-down'
    }.with_indifferent_access[current_user && current_user.attending_status(@event)]
  end

  def attending_text
    {pending: 'Vous participez',
     accepted: 'Vous participez',
     refused: 'Participation refusée',
     admin: 'orga',
     nil => 'Rejoindre'
    }.with_indifferent_access[current_user && current_user.attending_status(@event)]
  end
end

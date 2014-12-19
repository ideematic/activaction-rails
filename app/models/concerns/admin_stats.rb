class AdminStats
  def self.average_new_skills_per_user(since)
    user_count = User.where('created_at > ?', since).count
    skill_count = Skill.where('created_at > ?', since).count
    skill_count.to_f / user_count
  end

  def self.user_count_with_events
    User.joins(:events).where('events.user_id IS NOT NULL').group('users.id').count.count
  end

  def self.user_count_with_attended_events
    User.joins(:attended_events).where('events.user_id IS NOT NULL').group('users.id').count.count
  end

  def self.member_projects
    Event.joins(:user).where('users.is_admin = ?', false)
  end

  def self.user_count_for_category(category_id)
    '?'
    #User.joins(attended_events: :category).where('category.id = ?', category_id).count
  end
end
class User < ActiveRecord::Base
  has_many :events # organized_events
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :comments
  has_many :sent_chat_messages, foreign_key: 'sender_id', class_name: ChatMessage
  has_many :received_chat_messages, foreign_key: 'receiver_id', class_name: ChatMessage
  has_many :likes
  belongs_to :city
  has_many :tags, through: :events
  has_many :skills, through: :events
  has_many :user_wanted_tags
  has_many :user_unwanted_tags
  has_many :user_wanted_skills
  has_many :user_unwanted_skills
  has_many :wanted_tags, through: :user_wanted_tags, source: :tag
  has_many :unwanted_tags, through: :user_unwanted_tags, source: :tag
  has_many :wanted_skills, through: :user_wanted_skills, source: :skill
  has_many :unwanted_skills, through: :user_unwanted_skills, source: :skill

  STATUSES = [:accepted, :refused, :pending]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username, :first_name, :last_name
  validates_uniqueness_of :username
  # devise add email presence validation

  def attend_event(event, status = :pending)
    a = Attendance.where(user_id: self.id, event_id: event.id).first_or_create
    a.status = status
    a.save
  end

  # nil (no attendance), pending, accepted, refused or admin
  def attending_status(event)
    return 'admin' if self.owner_of?(event)
    a = Attendance.where(user_id: self.id, event_id: event.id).first
    a && a.status
  end

  def attending_to?(event)
    !self.attending_status(event).nil?
  end

  def attendance_for(event)
    Attendance.where(user_id: self.id, event_id: event.id).first
  end

  def owner_of?(ownable) # event or comment
    self.id == ownable.user_id
  end

  def get_like(likable)
    Like.where(user_id: self.id).where(event_id: likable.id).first
  end

  def gender_formatted
    {true => 'Femme', false => 'Homme', nil => '?'}[gender]
  end

  def skills_count
    skills.group_by(&:name).map { |k, v| [k, v.size] }
  end

  # Skills user has acquired through events, minus unwanted skills, plus wanted skills
  # by convention, we put wanted skills with a count of 0 in the hash
  def computed_skills
    skills_hash = Hash[skills_count] # {"générosité"=>1, "passion"=>2}
    wanted_skills_hash = Hash[wanted_skills.map { |s| [s.name, 0] }] # {"jonglage"=>0, "passion"=>0}
    wanted_skills_hash.merge(skills_hash).except(*unwanted_skills.map(&:name)) # {"générosité"=>1, "jonglage"=>0}
  end

end

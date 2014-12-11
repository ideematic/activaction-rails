class User < ActiveRecord::Base
  has_many :events
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :comments

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

  def attending_status(event)
    a = Attendance.where(user_id: self.id, event_id: event.id).first
    a && a.status
  end

  def attending_to?(event)
    !self.attending_status(event).nil?
  end

  def owner_of?(ownable) # event or comment
    self.id == ownable.user_id
  end
end

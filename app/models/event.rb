class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :event_tags
  has_many :tags, through: :event_tags
  has_many :attendances
  has_many :attending_users, through: :attendances, source: :user
  has_many :comments, as: :commentable

  validates_presence_of :user_id, :name, :description

  mount_uploader :picture, ImageUploader

  def tags=(tags)
    EventTag.where(event_id: self.id).delete_all
    tags.split(';').each do |t|
      new_tag = Tag.where(name: t).first_or_create
      EventTag.where(tag_id: new_tag.id, event_id: self.id).first_or_create
    end
  end

  def date_formatted
    date && date.strftime('%d/%m/%Y')
  end

  def hour_formatted
    date && date.strftime('%Hh%M')
  end

  def owned_by?(user)
    user.owner_of?(self)
  end

  def to_param
    "#{id} #{name}".parameterize
  end
end

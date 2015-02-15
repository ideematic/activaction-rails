class Tag < ActiveRecord::Base
  has_many :events, through: :event_tags
  has_many :event_tags
  has_many :user_wanted_tags
  has_many :user_unwanted_tags
  has_many :wanted_by, through: :user_wanted_tags, class_name: User
  has_many :unwanted_by, through: :user_unwanted_tags, class_name: User
end

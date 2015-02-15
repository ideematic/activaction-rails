class Skill < ActiveRecord::Base
  has_many :events, through: :event_skills
  has_many :event_skills
  has_many :user_wanted_skills
  has_many :user_unwanted_skills
  has_many :wanted_by, through: :user_wanted_skills, source: :user
  has_many :unwanted_by, through: :user_unwanted_skills, source: :user
end

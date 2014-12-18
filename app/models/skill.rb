class Skill < ActiveRecord::Base
  has_many :events, through: :event_skills
  has_many :event_skills
end

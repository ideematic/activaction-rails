class City < ActiveRecord::Base
  has_one :user

  def self.select_options
    order('priority DESC').all.map { |c| [c.name, c.id] }
  end
end

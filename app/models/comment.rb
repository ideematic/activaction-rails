class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  def owned_by?(user)
    user.owner_of?(self)
  end
end

class ChatMessage < ActiveRecord::Base
  belongs_to :sender, foreign_key: :sender_id, class_name: User
  belongs_to :receiver, foreign_key: :sender_id, class_name: User
end

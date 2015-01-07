class CreateChatMessages < ActiveRecord::Migration
  def change
    create_table :chat_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :content
      t.datetime :viewed_at

      t.timestamps
    end
  end
end

class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :status

      t.timestamps
    end
  end
end

class CreateEventTags < ActiveRecord::Migration
  def change
    create_table :event_tags do |t|
      t.string :event_id
      t.string :tag_id

      t.timestamps
    end
  end
end

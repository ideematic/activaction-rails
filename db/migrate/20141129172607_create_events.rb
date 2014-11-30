class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :user_id
      t.string :name
      t.datetime :date
      t.text :description
      t.string :picture

      t.timestamps
    end
  end
end

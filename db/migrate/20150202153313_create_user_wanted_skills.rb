class CreateUserWantedSkills < ActiveRecord::Migration
  def change
    create_table :user_wanted_skills do |t|
      t.integer :user_id
      t.integer :skill_id

      t.timestamps
    end
  end
end

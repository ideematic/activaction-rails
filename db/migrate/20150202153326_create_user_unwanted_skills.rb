class CreateUserUnwantedSkills < ActiveRecord::Migration
  def change
    create_table :user_unwanted_skills do |t|
      t.integer :user_id
      t.integer :skill_id

      t.timestamps
    end
  end
end

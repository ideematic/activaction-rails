class AddManualSkill < ActiveRecord::Migration
  def change
    add_column :users, :manual_skill, :text
  end
end

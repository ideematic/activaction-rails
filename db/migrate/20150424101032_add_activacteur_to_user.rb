class AddActivacteurToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_activacteur, :boolean, :default => false
  end
end

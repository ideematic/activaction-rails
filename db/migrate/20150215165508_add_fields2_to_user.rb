class AddFields2ToUser < ActiveRecord::Migration
  def change
    add_column :users, :birthdate, :date
    add_column :users, :studies, :string
    add_column :users, :desired_job, :string
    add_column :users, :professional_experiences, :text
    add_column :users, :education, :string
  end
end

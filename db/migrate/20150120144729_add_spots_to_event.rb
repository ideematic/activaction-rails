class AddSpotsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :spots, :integer
  end
end

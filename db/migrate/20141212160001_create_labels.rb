class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :label
      t.text :content

      t.timestamps
    end
  end
end

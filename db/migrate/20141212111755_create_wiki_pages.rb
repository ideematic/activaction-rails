class CreateWikiPages < ActiveRecord::Migration
  def change
    create_table :wiki_pages do |t|
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end

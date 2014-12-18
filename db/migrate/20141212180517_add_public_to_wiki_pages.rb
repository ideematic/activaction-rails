class AddPublicToWikiPages < ActiveRecord::Migration
  def change
    add_column :wiki_pages, :public, :boolean
  end
end

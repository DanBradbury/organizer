class CreateSiteManagers < ActiveRecord::Migration
  def change
    create_table :site_managers do |t|
      t.string :name
      t.string :url
      t.string :img
      t.integer :order

      t.timestamps
    end
  end
end

class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :region_name
      t.string :slug

      t.timestamps
    end
    
    add_index :regions, :slug, unique: true
    
  end
end

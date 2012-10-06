class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :title
      t.string :subtitle
      t.string :category
      t.string :description
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.string :region_name
      t.integer :region_id
      t.string :sport_name
      t.integer :sport_id
      t.string :channel_xmltv_id
      t.integer :channel_id

      t.timestamps
    end
        
    add_index :programs, :region_name
    add_index :programs, :sport_name
    add_index :programs, :channel_xmltv_id
    
  end
end

class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :rule_type
      t.integer :priority
      t.string :value
      t.datetime :start_date
      t.datetime :end_date
      t.integer :channel_id
      t.string :channel_xmltv_id
      t.integer :sport_id
      t.string :sport_name

      t.timestamps
    end
    
    add_index :rules :rule_type
    
  end
end

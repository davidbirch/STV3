class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :xmltv_id
      t.string :channel_name
      t.string :channel_short_name
      t.string :channel_logo_url
      t.string :channel_free_or_pay
      t.string :slug

      t.timestamps
    end
    
    add_index :channels, :slug, unique: true
    
  end
end

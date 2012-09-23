class CreateRawChannels < ActiveRecord::Migration
  def change
    create_table :raw_channels do |t|
      t.string :xmltv_id
      t.string :channel_name
      t.string :channel_short_name
      t.string :channel_logo_url
      t.string :channel_free_or_pay

      t.timestamps
    end
  end
end

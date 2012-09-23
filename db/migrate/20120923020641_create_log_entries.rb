class CreateLogEntries < ActiveRecord::Migration
  def change
    create_table :log_entries do |t|
      t.string :level
      t.string :value

      t.timestamps
    end
  end
end

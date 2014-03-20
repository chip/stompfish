class CreateImportLogs < ActiveRecord::Migration
  def change
    create_table :import_logs do |t|
      t.text :stacktrace
      t.text :filename

      t.timestamps
    end
  end
end

class CreateReleaseDates < ActiveRecord::Migration
  def change
    create_table :release_dates do |t|
      t.integer :year, default: 0, null: false

      t.timestamps
    end
  end
end

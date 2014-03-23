class AddIndexToIdForReleaseDates < ActiveRecord::Migration
  def change
    add_index :release_dates, :id
  end
end

class AddIndexToIdOnGenres < ActiveRecord::Migration
  def change
    add_index :genres, :id
  end
end

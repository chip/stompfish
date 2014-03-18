class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :image
      t.integer :artist_id
      t.string :genre
      t.string :date

      t.timestamps
    end
  end
end

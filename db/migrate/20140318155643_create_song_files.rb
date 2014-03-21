class CreateSongFiles < ActiveRecord::Migration
  def change
    create_table :song_files do |t|
      t.integer :song_id
      t.integer :filesize
      t.string :filename
      t.integer :bitrate
      t.string :format
      t.float :duration

      t.timestamps
    end
  end
end

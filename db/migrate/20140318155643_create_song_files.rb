class CreateSongFiles < ActiveRecord::Migration
  def change
    create_table :song_files do |t|
      t.integer :song_id
      t.string :filesize
      t.string :filename
      t.string :bitrate
      t.string :format
      t.string :duration

      t.timestamps
    end
  end
end

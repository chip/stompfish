class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :title, default: "", null: false

      t.timestamps
    end
  end
end

class ChangeArtistNameToText < ActiveRecord::Migration
  def change
    change_column :artists, :name, :text, default: "", :null => false
  end
end

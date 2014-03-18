class AddValidationToArtists < ActiveRecord::Migration
  def change
    change_column :artists, :name, :string, default: "", :null => false
  end
end

class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name, default: "", null: false

      t.timestamps
    end
  end
end

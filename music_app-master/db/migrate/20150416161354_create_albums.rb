class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, null: false
      t.string :studio_or_live, null: false

      t.timestamps
    end

    add_index :albums, :band_id
    add_index :albums, :name
  end
end

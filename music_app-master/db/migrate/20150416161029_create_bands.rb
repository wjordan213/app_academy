class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end

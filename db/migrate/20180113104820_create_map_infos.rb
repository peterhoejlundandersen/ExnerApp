class CreateMapInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :map_infos do |t|
      t.text :text
			t.decimal :lat_x, precision: 8, scale: 6
			t.decimal :lat_y, precision: 8, scale: 6
      t.string :link
      t.string :image
      t.references :work, foreign_key: true
      t.string :address
      t.timestamps
    end
  end
end

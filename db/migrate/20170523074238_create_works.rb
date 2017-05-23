class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.integer :sagsnr
      t.string :name
      t.text :description
      t.string :competition
      t.string :address
      t.integer :category_id

      t.timestamps
    end
  end
end

class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :image
      t.text :image_description
      t.integer :image_category_id
      t.string :photographer
      t.text :info, array: true, default: [""]
      t.timestamps
    end
  end
end

class CreateImageCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :image_categories do |t|
      t.string :name
      t.integer :work_id

      t.timestamps
    end
  end
end

class AddImageToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :image, :text
  end
end

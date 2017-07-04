class AddPositionToImageCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :image_categories, :position, :integer
  end
end

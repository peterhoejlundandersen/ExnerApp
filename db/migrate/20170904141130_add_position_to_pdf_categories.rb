class AddPositionToPdfCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :pdf_categories, :position, :integer
  end
end

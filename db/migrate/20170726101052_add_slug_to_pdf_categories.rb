class AddSlugToPdfCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :pdf_categories, :slug, :string
    add_index :pdf_categories, :slug, unique: true
  end
end

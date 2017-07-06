class CreatePdfCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :pdf_categories do |t|
      t.string :title
      t.belongs_to :johannes_writing
      t.timestamps
    end
  end
end

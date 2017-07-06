class CreatePdfs < ActiveRecord::Migration[5.1]
  def change
    create_table :pdfs do |t|
      t.string :title
      t.string :file
      t.belongs_to :pdf_category
      t.timestamps
    end
  end
end

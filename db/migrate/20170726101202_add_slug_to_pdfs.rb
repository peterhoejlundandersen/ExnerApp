class AddSlugToPdfs < ActiveRecord::Migration[5.1]
  def change
    add_column :pdfs, :slug, :string
    add_index :pdfs, :slug, unique: true
  end
end

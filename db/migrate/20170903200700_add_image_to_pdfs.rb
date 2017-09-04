class AddImageToPdfs < ActiveRecord::Migration[5.1]
  def change
    add_column :pdfs, :image, :string
  end
end

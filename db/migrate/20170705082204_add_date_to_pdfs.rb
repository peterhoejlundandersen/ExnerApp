class AddDateToPdfs < ActiveRecord::Migration[5.1]
  def change
    add_column :pdfs, :date, :string
  end
end

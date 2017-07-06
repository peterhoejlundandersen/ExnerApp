class AddDateAgainToPdfs < ActiveRecord::Migration[5.1]
  def change
  	remove_column :pdfs, :date, :datetime
  	add_column :pdfs, :date, :string
  end
end

class AddOpeningYearToPdfs < ActiveRecord::Migration[5.1]
  def change
    add_column :pdfs, :opening_year, :integer
  end
end

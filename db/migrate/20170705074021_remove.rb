class Remove < ActiveRecord::Migration[5.1]
  def change
  	remove_column :pdf_categories, :johannes_writing_id
  end
end

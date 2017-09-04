class AddPositionToPdf < ActiveRecord::Migration[5.1]
  def change
    add_column :pdfs, :position, :integer
  end
end

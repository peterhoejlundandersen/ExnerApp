class AddPdfToJohannesWritings < ActiveRecord::Migration[5.1]
  def change
    add_column :johannes_writings, :pdf, :string
  end
end

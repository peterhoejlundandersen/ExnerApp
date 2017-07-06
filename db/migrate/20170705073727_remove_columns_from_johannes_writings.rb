class RemoveColumnsFromJohannesWritings < ActiveRecord::Migration[5.1]
  def change
  	remove_column :johannes_writings, :remote_url_amazon, :string
  	remove_column :johannes_writings, :pdf, :string
  end
end

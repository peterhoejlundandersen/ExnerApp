class AddInfoToWorks < ActiveRecord::Migration[5.1]
  def change
  	add_column :works, :info, :text, array: true, default: [""]
  end
end

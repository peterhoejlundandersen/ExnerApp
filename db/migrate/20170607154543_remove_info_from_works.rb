class RemoveInfoFromWorks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :works, :info 
  end
end

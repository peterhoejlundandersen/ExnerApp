class RemoveWorkIdFromInfo < ActiveRecord::Migration[5.1]
  def change
  	remove_column :infos, :work_id
  end
end

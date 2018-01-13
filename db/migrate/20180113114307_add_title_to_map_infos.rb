class AddTitleToMapInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :map_infos, :title, :string
  end
end

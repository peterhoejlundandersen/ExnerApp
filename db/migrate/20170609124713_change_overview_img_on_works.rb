class ChangeOverviewImgOnWorks < ActiveRecord::Migration[5.1]
  def change
  	remove_column :works, :overview_img, :text
  	add_column :works, :overview_img, :string
  end
end

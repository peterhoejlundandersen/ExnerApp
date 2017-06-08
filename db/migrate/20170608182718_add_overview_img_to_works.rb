class AddOverviewImgToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :overview_img, :text
  end
end

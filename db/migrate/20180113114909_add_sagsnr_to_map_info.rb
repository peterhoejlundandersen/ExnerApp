class AddSagsnrToMapInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :map_infos, :sagsnr, :integer
  end
end

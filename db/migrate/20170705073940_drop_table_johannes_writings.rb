class DropTableJohannesWritings < ActiveRecord::Migration[5.1]
  def change
  	drop_table :johannes_writings
  end
end

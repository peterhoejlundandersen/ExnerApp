class CreateJohannesWritings < ActiveRecord::Migration[5.1]
  def change
    create_table :johannes_writings do |t|
    	t.string :title
    	t.timestamps
    end
  end
end

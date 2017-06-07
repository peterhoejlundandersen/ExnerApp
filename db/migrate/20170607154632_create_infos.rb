class CreateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :infos do |t|
    	t.string :title
    	t.integer :work_id
      t.timestamps
    end
  end
end

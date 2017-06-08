class CreateImageUploaders < ActiveRecord::Migration[5.1]
  def change
    create_table :image_uploaders do |t|

      t.timestamps
    end
  end
end

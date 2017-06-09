class RemoveTableUploadImages < ActiveRecord::Migration[5.1]
  def change
  	drop_table :image_uploaders
  end
end

class AddDefaultToIsReviewImgWorks < ActiveRecord::Migration[5.1]
  def change
  	change_column :images, :is_review_img, :boolean, default: false
  end
end

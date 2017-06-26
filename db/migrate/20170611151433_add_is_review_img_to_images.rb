class AddIsReviewImgToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :is_review_img, :boolean
  end
end

class AddLinkImageToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :link_image, :string
  end
end

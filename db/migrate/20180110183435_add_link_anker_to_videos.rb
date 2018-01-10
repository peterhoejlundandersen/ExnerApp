class AddLinkAnkerToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :link_anker, :string
  end
end

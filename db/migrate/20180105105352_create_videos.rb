class CreateVideos < ActiveRecord::Migration[5.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.string :link
      t.boolean :only_link, default: false

      t.timestamps
    end
  end
end

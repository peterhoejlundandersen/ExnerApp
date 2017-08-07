class AddDraftToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :draft, :boolean, default: false
  end
end

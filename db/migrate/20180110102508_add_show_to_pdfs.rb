class AddShowToPdfs < ActiveRecord::Migration[5.1]
  def change
    add_column :pdfs, :show_not, :boolean, default: false
  end
end

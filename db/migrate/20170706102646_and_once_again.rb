class AndOnceAgain < ActiveRecord::Migration[5.1]
  def change
  	remove_column :pdfs, :date, :string
  	add_column :pdfs, :date, :datetime
  end
end

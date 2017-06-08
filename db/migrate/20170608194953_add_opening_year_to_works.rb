class AddOpeningYearToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :opening_year, :integer
    remove_column :works, :competition, :string
    add_column :works, :competition, :integer
  end
end

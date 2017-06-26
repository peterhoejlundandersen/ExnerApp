class AddSlugToJohannesWritings < ActiveRecord::Migration[5.1]
  def change
    add_column :johannes_writings, :slug, :string
    add_index :johannes_writings, :slug, unique: true
  end
end

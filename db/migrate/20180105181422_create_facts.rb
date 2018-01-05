class CreateFacts < ActiveRecord::Migration[5.1]
  def change
    create_table :facts do |t|
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end

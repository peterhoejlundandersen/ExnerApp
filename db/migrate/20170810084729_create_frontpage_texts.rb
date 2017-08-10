class CreateFrontpageTexts < ActiveRecord::Migration[5.1]
  def change
    create_table :frontpage_texts do |t|
      t.text :text

      t.timestamps
    end
  end
end

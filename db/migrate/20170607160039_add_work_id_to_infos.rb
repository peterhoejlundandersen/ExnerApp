class AddWorkIdToInfos < ActiveRecord::Migration[5.1]
  def change
    add_reference :infos, :work, foreign_key: true
  end
end

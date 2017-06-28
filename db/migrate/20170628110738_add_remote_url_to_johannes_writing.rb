class AddRemoteUrlToJohannesWriting < ActiveRecord::Migration[5.1]
  def change
    add_column :johannes_writings, :remote_url_amazon, :string
  end
end

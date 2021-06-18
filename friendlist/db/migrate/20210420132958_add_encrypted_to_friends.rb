class AddEncryptedToFriends < ActiveRecord::Migration[6.0]
  def change
    add_column :friends, :encrypted, :boolean
  end
end

class ChangeFriendshipsStatusDefaultValueToFalse < ActiveRecord::Migration[6.0]
  def change
    change_column :friendships, :status, :boolean, default: false
  end
end

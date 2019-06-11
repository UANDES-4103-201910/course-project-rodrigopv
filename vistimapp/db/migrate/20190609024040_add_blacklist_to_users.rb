class AddBlacklistToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :blacklist, :boolean
  end
end

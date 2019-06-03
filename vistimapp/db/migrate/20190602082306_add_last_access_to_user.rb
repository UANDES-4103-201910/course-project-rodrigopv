class AddLastAccessToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_access, :datetime
  end
end

class FixAuthorName < ActiveRecord::Migration[5.2]
  def change
      rename_column :complaints, :author_id, :user_id
  end
end

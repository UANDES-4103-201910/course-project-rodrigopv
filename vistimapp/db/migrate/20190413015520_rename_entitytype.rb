class RenameEntitytype < ActiveRecord::Migration[5.2]
  def change
      rename_column :entities, :entitytype_id, :entity_type_id
  end
end

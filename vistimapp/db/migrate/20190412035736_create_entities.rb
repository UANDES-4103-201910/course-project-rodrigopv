class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    create_table :entities do |t|
      t.references :entitytype
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

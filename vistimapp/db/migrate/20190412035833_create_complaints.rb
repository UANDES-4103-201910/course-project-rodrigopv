class CreateComplaints < ActiveRecord::Migration[5.2]
  def change
    create_table :complaints do |t|
      t.references :author
      t.references :category
      t.references :entity
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

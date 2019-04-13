class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :user
      t.references :complaint
      t.text :content

      t.timestamps
    end
  end
end

class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.string :type
      t.references :user
      t.text :comment
      t.binary :bin_content

      t.timestamps
    end
  end
end

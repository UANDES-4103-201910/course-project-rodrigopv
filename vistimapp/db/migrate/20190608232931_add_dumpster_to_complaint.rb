class AddDumpsterToComplaint < ActiveRecord::Migration[5.2]
  def change
    add_column :complaints, :dumpster, :boolean
  end
end

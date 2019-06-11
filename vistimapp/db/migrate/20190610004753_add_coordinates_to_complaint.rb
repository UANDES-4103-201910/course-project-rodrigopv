class AddCoordinatesToComplaint < ActiveRecord::Migration[5.2]
  def change
    add_column :complaints, :lat, :string
    add_column :complaints, :lng, :string
  end
end

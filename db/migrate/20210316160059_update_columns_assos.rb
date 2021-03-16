class UpdateColumnsAssos < ActiveRecord::Migration[6.0]
  def change
    rename_column :assos, :localisation, :address
    add_column :assos, :city, :string
    add_column :assos, :zipcode, :string
    add_column :assos, :longitude, :float
    add_column :assos, :latitude, :float
    remove_column :assos, :created_at, :datetime
    remove_column :assos, :updated_at, :datetime
  end
end

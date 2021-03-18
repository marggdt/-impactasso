class AddColumnToAssos < ActiveRecord::Migration[6.0]
  def change
    add_column :assos, :image_url, :string
  end
end

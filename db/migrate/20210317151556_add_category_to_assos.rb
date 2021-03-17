class AddCategoryToAssos < ActiveRecord::Migration[6.0]
  def change
    add_column :assos, :category, :string
  end
end

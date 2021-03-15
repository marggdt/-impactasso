class CreateAssociations < ActiveRecord::Migration[6.0]
  def change
    create_table :associations do |t|
      t.string :name
      t.text :description
      t.string :localisation

      t.timestamps
    end
  end
end

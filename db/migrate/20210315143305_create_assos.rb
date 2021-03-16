class CreateAssos < ActiveRecord::Migration[6.0]
  def change
    create_table :assos do |t|
      t.string :name
      t.text :description
      t.string :localisation

      t.timestamps
    end
  end
end

class CreateMissions < ActiveRecord::Migration[6.0]
  def change
    create_table :missions do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :address

    end
  end
end

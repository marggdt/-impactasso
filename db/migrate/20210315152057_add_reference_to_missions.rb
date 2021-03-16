class AddReferenceToMissions < ActiveRecord::Migration[6.0]
  def change
    add_reference :missions, :asso, null: false, foreign_key: true
  end
end

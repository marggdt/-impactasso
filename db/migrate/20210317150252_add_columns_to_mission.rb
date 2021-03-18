class AddColumnsToMission < ActiveRecord::Migration[6.0]
  def change
    add_column :missions, :web_scraper_order, :text
    add_column :missions, :web_scraper_start_url, :text
    add_column :missions, :title, :string
    add_column :missions, :lieu, :string
    add_column :missions, :type_mission, :string
    add_column :missions, :date_mission, :string
    add_column :missions, :dispo, :string
    add_column :missions, :asso, :string
  end
end

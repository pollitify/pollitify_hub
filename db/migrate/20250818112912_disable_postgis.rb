class DisablePostgis < ActiveRecord::Migration[8.0]
  def change
    if Rails.env.development?
      disable_extension "postgis"
    end
  end
end

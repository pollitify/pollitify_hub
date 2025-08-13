class MakeCityNameBeCiText < ActiveRecord::Migration[8.0]
  def change
    enable_extension "citext"
  end
end

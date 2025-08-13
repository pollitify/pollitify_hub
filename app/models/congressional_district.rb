class CongressionalDistrict < ApplicationRecord
  belongs_to :state
  belongs_to :key_county
end

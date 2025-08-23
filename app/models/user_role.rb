class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates :role_id, uniqueness: { scope: :user_id }
  
  IDENTITY_RELATIONSHIP = :all # could also be :all
  IDENTITY_COLUMNS = [:role_id, :user_id]
  include FindOrCreate
  
end

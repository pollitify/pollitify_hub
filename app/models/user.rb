class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :password, length: { maximum: 20 }
  validate :valid_date?

  # enum :role, { user: "user", admin: "admin" }
  # validates :role, inclusion: { in: roles.keys }

  has_many :user_roles
  has_many :roles, through: :user_roles

  def full_name
    [ first_name, last_name ].join(" ")
  end

  def super_admin?
    admin? && email == ENV["ADMIN_EMAIL"]
  end
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  
  # You can dynamically define role-checking methods like:
  #
  # ruby
  # Copy
  # Edit
  # app/models/user.rb
  Role.pluck(:name).each do |role_name|
    define_method("#{role_name}?") do
      has_role?(role_name)
    end
  end
  #Now you can call current_user.admin?, current_user.super_user?, etc.

  
  
  def has_role?(role_name)
    roles.exists?(name: role_name.to_s)
  end
  
  def is_super_user?
    return true if self.has_role?("super_user")
    return false
  end
  
  def admin?
    return true if self.has_role?("admin")
    return false
  end
  
  def has_editing_privileges?
    return true if self.has_role?("editor")
    return false
  end
  

  private

  def valid_date?
    if date_of_birth.present? && date_of_birth > Time.now.ago(15.years)
      errors.add(:date_of_birth, "must be at least 15 years old")
    end
  end
end

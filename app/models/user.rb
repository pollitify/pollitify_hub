class User < ApplicationRecord
  belongs_to :state, optional: true
  belongs_to :county, optional: true
  belongs_to :city, optional: true
  belongs_to :federal_congressional_district, class_name: "CongressionalDistrict", optional: true
  belongs_to :state_congressional_district, class_name: "CongressionalDistrict", optional: true
  
  def state?
    return true if self.state
  end
  
  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable
         #:confirmable, 

  validates :email, presence: true, uniqueness: true
  # validates :password, presence: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  #validates :username, presence: true, uniqueness: true
  # validates :username, presence: true,
  #                      uniqueness: { case_sensitive: false },
  #                      length: { minimum: 3, maximum: 20 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :password, length: { maximum: 20 }
  validate :valid_date?
  
  attr_accessor :login
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(
        ["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]
      ).first
    else
      where(conditions).first
    end
  end

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
  
  acts_as_voter
  
  has_many :user_roles
  has_many :roles, through: :user_roles
  
  def is_superuser?
    return true if self.username == 'fuzzygroup'
  end
  
  # You can dynamically define role-checking methods like:
  #
  # ruby
  # Copy
  # Edit
  # app/models/user.rb
  # Role.pluck(:name).each do |role_name|
  #   define_method("#{role_name}?") do
  #     has_role?(role_name)
  #   end
  # end
  #Now you can call current_user.admin?, current_user.super_user?, etc.
  
  def self.taelar
    User.where(username: 'taelar').first
  end
  
  def self.alex
    User.where(username: 'alex').first
  end
  
  def self.kayla
    User.where(username: 'kayla').first
  end

  def self.scott
    User.where(username: 'fuzzygroup').first
  end

  def self.fuzzygroup
    User.where(username: 'fuzzygroup').first
  end

  
  def has_role?(role_name)
    roles.exists?(name: role_name.to_s)
  end
  
  def is_super_user?
    return true if self.has_role?("super_user")
    return true if self.email =~ /fuzzygroup/i
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
  
  def is_admin?
    return true if self.email =~ /fuzzygroup/
  end
  
  def has_destroy_rights?(foo)
    return true if self.email =~ /fuzzygroup/
  end
  
  def to_param
    username.parameterize
  end
  

  private

  def valid_date?
    if date_of_birth.present? && date_of_birth > Time.now.ago(15.years)
      errors.add(:date_of_birth, "must be at least 15 years old")
    end
  end
end

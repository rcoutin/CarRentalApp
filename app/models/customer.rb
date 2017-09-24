class Customer < ApplicationRecord
  has_one :reservation
    
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email:true, uniqueness: true
  validates :password_digest, presence: true
  validates :license_number, presence: true

  has_secure_password
end

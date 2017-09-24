class Admin < ApplicationRecord
	validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email:true, uniqueness: true
  validates :password_digest, presence: true

  has_secure_password
end

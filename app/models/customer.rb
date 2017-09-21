class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :email, presence: true, email: true, uniqueness: true
  # validates :password, presence: true, length: { in: 6..20 }
  # validates :licence_number, presence: true, uniqueness: true
end

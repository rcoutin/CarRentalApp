class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, email:true
  validates :password, presence: true
  validates :license_number, presence: true
end

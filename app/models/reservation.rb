class Reservation < ApplicationRecord
  validates :customer_id, presence: true, uniqueness: true
  validates :car_id, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true


end

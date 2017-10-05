class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :car
  validates :customer_id, presence: true
  validates :car_id, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true

 # validate :from_time_and_to_time_comparison

end

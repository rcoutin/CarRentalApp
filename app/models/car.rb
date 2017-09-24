class Car < ApplicationRecord

  validates :license_number, presence: true, length: {is: 7}
  validates :manufacturer, presence: true
  validates :model, presence: true, inclusion: {in: {"Sedan", "Coupe", "SUV"}
  validates :style, presence: true
  has_one :reservation
end

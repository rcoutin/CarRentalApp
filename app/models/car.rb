class Car < ApplicationRecord
  validates :manufacturer, presence: true

  validates :model, presence: true#, inclusion: {in: %w(Coupe Sedan SUV), message:"%{value} is not a valid "}

  validates :license_number, presence: true, length: {is: 7}
  validates :style, presence: true, inclusion: {in: ["Sedan", "Coupe", "SUV"]}
  validates :status, presence: true, inclusion: {in: ["R", "C", "A"]}

  has_one :reservation
end

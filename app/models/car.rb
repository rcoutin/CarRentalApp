class Car < ApplicationRecord
  validates :manufacturer, :presence => {:message => "Please enter the manufacturer name"}

  validates :model, :presence => {:message => "Please enter the model name"}

  validates :license_number, presence: true, length: {is: 7,  :message => "Please enter the 7 digit licence number"}
  validates :style, presence: true, inclusion: {in: ["Sedan", "Coupe", "SUV"] ,:message => "Please enter a valid car style"}

  validates :status, presence: true, inclusion: {in: ["R", "C", "A"] ,:message => "Please enter a valid status"}
  validates :rate, presence: true
  validates :location, presence: true

  has_one :reservation

  def self.search(term)
    term=term.downcase
    if term
      where('lower(model) LIKE ? OR lower(manufacturer) LIKE ? OR lower(style) LIKE ? OR lower(status) LIKE ? OR lower(location) LIKE ?', "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%")
    else
      all
    end
  end

  def self.set_status(car_id, status)
   find(car_id).update(:status => status)
  end
end

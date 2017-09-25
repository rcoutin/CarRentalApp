class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :car
  validates :customer_id, presence: true
  validates :car_id, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true

  validate :from_time_and_to_time_comparison

  def from_time_and_to_time_comparison
 		if from_time - DateTime.current < 0
 			errors.add(:from_time, 'Time cannot be in the past.')
 		end
 		if (from_time - DateTime.current) / 24 / 60 / 60 > 7
 			errors.add(:from_time, 'The reservation time has to be in the next one week.')
 		end
  	if to_time < from_time
  		errors.add(:to_time, 'The time cannot be before the initial reservation time.')
  	end
  	if to_time.hour - from_time.hour < 1
  		errors.add(:to_time, 'The minimum reservation time is 1 hour.')
  	end
  	if to_time.hour - from_time.hour > 10
  		errors.add(:to_time, 'The maximum reservation time is 10 hours.')
  	end
  end
end

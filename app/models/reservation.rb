class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :car
  validates :customer_id, presence: true
  validates :car_id, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true

  validate :from_time_and_to_time_comparison

  def from_time_and_to_time_comparison
    if from_time == nil
      errors.add(:from_time, 'Invalid time entry.')
      puts "1"
    elsif to_time == nil
      errors.add(:to_time, 'Invalid time entry.')
      puts "2"
 		elsif ((from_time - DateTime.now) + ( 4 * 60 * 60 )) < 0
 			errors.add(:from_time, 'Time cannot be in the past.')
      puts "3"
 		elsif (from_time - DateTime.now) / 24 / 60 / 60 > 7
 			errors.add(:from_time, 'The reservation time has to be in the next one week.')
      puts "4"
  	elsif to_time < from_time
  		errors.add(:to_time, 'The time cannot be before the initial reservation time.')
      puts "5"
  	elsif to_time - from_time < 3600
  		errors.add(:to_time, 'The minimum reservation time is 1 hour.')
      puts "6"
      puts to_time - from_time
  	elsif to_time - from_time > 36000
  		errors.add(:to_time, 'The maximum reservation time is 10 hours.')
      puts "7"
  	end
  end
end

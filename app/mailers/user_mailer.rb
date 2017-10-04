class UserMailer < ApplicationMailer
  default from: 'onepluscarrental@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://one-plus-car-rental.herokuapp.com'
    mail(to: @user.email, subject: 'Welcome to OnePlus Car Rental Service')
  end

  def notification_return(user, car)
    @user = user
    @car = car
    @url  = 'https://one-plus-car-rental.herokuapp.com'
    mail(to: @user.email, subject: 'Reservation Time is Up!')
  end
end

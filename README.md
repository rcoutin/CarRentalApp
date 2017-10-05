# CSC 517 Program 2 - OnePlus Car Rental Application

#### Note: Do not use the fake e-mail IDs during signup
The application requires you to make use of legitimate e-mails IDs (and not fake email IDs) for **best experience**. As we are using e-mails for notifications, kindly use your personal e-mail IDs to test the application.

### LINK: https://one-plus-car-rental.herokuapp.com/
## Credentials

##### SuperAdmins
Only one superadmin has been created during deployment. To login, the superadmin should use the admins login option which can be found on the homepage.
```
e-mail: jsmith@example.com  
password: a  
```
##### Admins
To create new admin/superadmin, a admin/superadmin has to click on the "Manage Admins" link provided on his homepage after logging in.   
##### Customers
A customer can use the sign up option and create an account. The customer will then get a _**welcome e-mail**_ in the e-mail that he/she used to register.
## Problem Statement
The full problem statement can be found [here](http://www.csc2.ncsu.edu/faculty/efg/517/f17/www/homework/program2.html).

## Functionality covered
* _Customers can:_  
	* Signup and Login
	* Edit his/her profile
	* Reserve a car based on the number (one reservation per user) and time constraints present in the Problem Statement
    * View and Cancel their reservations and also Checkout and Return the cars
    * Suggest a car to be added (added upon admins approval)
    * View his/her own reservations and reservation history
    * Pay the rental charge applicable
    * Subscribe to reserved cars to get notified when they become available

* _Admins can_  
	* Be added/deleted by other admins/superadmins
	* Manage other admins
	* Manage cars (CRUD) as per requirement
	* Manage customers (RUD) as per requirement
	* Manage reservations (CRUD) as per requirement
	* Accept/Reject car suggestions by users
	* View Current and Past reservation of each user by viewing their profile
	* View each car's Checkout history


* _Superadmins can_  
	* Be created by other superadmins
	* Perform everything that an admin can
	* not be deleted by anyone


* _Cars_  
	* A car can be added/removed by a(n) Admin/Superadmin
	* Anyone can view the details of the car
	* Admin/Superadmins can view a car's checkout history

* _Reservations_  
	* A customer can only have one reservation posted on his account at a time, even when the reservation is of a future date
	* All car reservations, when completed a full flow (Available -> Reserved -> Checked Out -> Returned) will be added in the reservation history.
	* Admins/Superadmins can view all customers' reservations

* _Viewing Past Reservations_  
	* Customer can view his/her past reservations
	* Admins/Superadmins can view all customers' past reservations

* _Deleting users/admin_  
	* Customers can be deleted by Admins/Superadmins
	* Admins can be deleted by Superadmins
	* Superadmins cannot be deleted
	* A customer cannot be deleted if he/she has an ongoing reservation

* _Deleting cars_  
	* Admins and Superadmins can delete cars
	* A car cannot be deleted if it is a part of an ongoing reservation

* _Search Cars_
	* Customers can search cars based on Model Name/ Manufacturer/ Location/ Status/ Style in one search box

* _Notifications are sent when_
	* 	User Signs up successfully
	* 	A car suggestion by a user is approved
	* 	A car suggestion by a user is rejected
	* 	A car which the customer has subscribed to becomes available
	* 	A car is automatically returned when reservation time runs out

## Routes
```
                   Prefix Verb   URI Pattern                             Controller#Action
        unauthorized_show GET    /unauthorized/show(.:format)            unauthorized#show
     application_sign_out GET    /application/sign_out(.:format)         application#sign_out
      reservations_cancel GET    /reservations/cancel(.:format)          reservations#cancel
    reservations_checkout GET    /reservations/checkout(.:format)        reservations#checkout
      reservations_return GET    /reservations/return(.:format)          reservations#return
    car_approvals_approve GET    /car_approvals/approve(.:format)        car_approvals#approve
            customers_pay GET    /customers/pay(.:format)                customers#pay
                customers GET    /customers(.:format)                    customers#index
                          POST   /customers(.:format)                    customers#create
             new_customer GET    /customers/new(.:format)                customers#new
            edit_customer GET    /customers/:id/edit(.:format)           customers#edit
                 customer GET    /customers/:id(.:format)                customers#show
                          PATCH  /customers/:id(.:format)                customers#update
                          PUT    /customers/:id(.:format)                customers#update
                          DELETE /customers/:id(.:format)                customers#destroy
              login_index POST   /login(.:format)                        login#create
                new_login GET    /login/new(.:format)                    login#new
       admins_login_index POST   /admins_login(.:format)                 admins_login#create
         new_admins_login GET    /admins_login/new(.:format)             admins_login#new
                   admins GET    /admins(.:format)                       admins#index
                          POST   /admins(.:format)                       admins#create
                new_admin GET    /admins/new(.:format)                   admins#new
               edit_admin GET    /admins/:id/edit(.:format)              admins#edit
                    admin GET    /admins/:id(.:format)                   admins#show
                          PATCH  /admins/:id(.:format)                   admins#update
                          PUT    /admins/:id(.:format)                   admins#update
                          DELETE /admins/:id(.:format)                   admins#destroy
                     cars GET    /cars(.:format)                         cars#index
                          POST   /cars(.:format)                         cars#create
                  new_car GET    /cars/new(.:format)                     cars#new
                 edit_car GET    /cars/:id/edit(.:format)                cars#edit
                      car GET    /cars/:id(.:format)                     cars#show
                          PATCH  /cars/:id(.:format)                     cars#update
                          PUT    /cars/:id(.:format)                     cars#update
                          DELETE /cars/:id(.:format)                     cars#destroy
             reservations GET    /reservations(.:format)                 reservations#index
                          POST   /reservations(.:format)                 reservations#create
          new_reservation GET    /reservations/new(.:format)             reservations#new
         edit_reservation GET    /reservations/:id/edit(.:format)        reservations#edit
              reservation GET    /reservations/:id(.:format)             reservations#show
                          PATCH  /reservations/:id(.:format)             reservations#update
                          PUT    /reservations/:id(.:format)             reservations#update
                          DELETE /reservations/:id(.:format)             reservations#destroy
reservation_history_index GET    /reservation_history(.:format)          reservation_history#index
                          POST   /reservation_history(.:format)          reservation_history#create
  new_reservation_history GET    /reservation_history/new(.:format)      reservation_history#new
 edit_reservation_history GET    /reservation_history/:id/edit(.:format) reservation_history#edit
      reservation_history GET    /reservation_history/:id(.:format)      reservation_history#show
                          PATCH  /reservation_history/:id(.:format)      reservation_history#update
                          PUT    /reservation_history/:id(.:format)      reservation_history#update
                          DELETE /reservation_history/:id(.:format)      reservation_history#destroy
            notifications GET    /notifications(.:format)                notifications#index
                          POST   /notifications(.:format)                notifications#create
         new_notification GET    /notifications/new(.:format)            notifications#new
        edit_notification GET    /notifications/:id/edit(.:format)       notifications#edit
             notification GET    /notifications/:id(.:format)            notifications#show
                          PATCH  /notifications/:id(.:format)            notifications#update
                          PUT    /notifications/:id(.:format)            notifications#update
                          DELETE /notifications/:id(.:format)            notifications#destroy
            car_approvals GET    /car_approvals(.:format)                car_approvals#index
                          POST   /car_approvals(.:format)                car_approvals#create
         new_car_approval GET    /car_approvals/new(.:format)            car_approvals#new
        edit_car_approval GET    /car_approvals/:id/edit(.:format)       car_approvals#edit
             car_approval GET    /car_approvals/:id(.:format)            car_approvals#show
                          PATCH  /car_approvals/:id(.:format)            car_approvals#update
                          PUT    /car_approvals/:id(.:format)            car_approvals#update
                          DELETE /car_approvals/:id(.:format)            car_approvals#destroy
                     root GET    /                                       login#new


```

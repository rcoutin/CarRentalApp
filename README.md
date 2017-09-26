# CSC 517 Program 2 - OnePlus Car Rental Application


## Credentials

###### SuperAdmins
Only one superadmin has been created. The superadmin should use the admins login option which can be found on the homepage.
```
e-mail: john@smith.com  
password: a  
```
###### Admins
To create new admin/superadmin, a superadmin has to go to link '/admins/new' after logging in.   
###### Customers
A customer can use the sign up option and create an account.
## Problem Statement
The full problem statement can be found [here](http://www.csc2.ncsu.edu/faculty/efg/517/f17/www/homework/program2.html).

## Functionality covered
* _Customers_  
Customers can login and reserve a car based on the time constraints present in the Problem Statement. They can also view/edit/cancel their reservations and also checkout and return them.  


* _Cars_  
A car can be created by admin/superadmin. A car can have status as available/reserved/checked-out as per its current state. Once the car is reserved, it will no longer be visible to customers to reserve. Once the reservation ends, the customers can reserve the car again. Customers can also edit the time of their reservation.


* _Admins_  
Admins can view all customers and cars. They can also add a car, edit a reservation for the customer and also book a car for a particular customer. Admins can add other admins.


* _Superadmins_  
Superadmins can add admins and superadmins. They perform everything that an admin can perform.


* _Reservations_  
A reservation can only succeed when the customer does not have any current reservation. The car has to be available for the reservation to take place.

## Functionality not covered - We're working on it!
* _Viewing Past Reservations_  
Customer cannot view his past reservations. Once a reservation is done, it cannot be retrieved again (for now).


* _Deleting users/admin_  
No user can be currently deleted.


* _Deleting cars_  
No one can delete cars.

## Routes
```
             Prefix Verb   URI Pattern                      Controller#Action
    unauthorized_show GET    /unauthorized/show(.:format)     unauthorized#show
 application_sign_out GET    /application/sign_out(.:format)  application#sign_out
  reservations_cancel GET    /reservations/cancel(.:format)   reservations#cancel
reservations_checkout GET    /reservations/checkout(.:format) reservations#checkout
  reservations_return GET    /reservations/return(.:format)   reservations#return
            customers GET    /customers(.:format)             customers#index
                      POST   /customers(.:format)             customers#create
         new_customer GET    /customers/new(.:format)         customers#new
        edit_customer GET    /customers/:id/edit(.:format)    customers#edit
             customer GET    /customers/:id(.:format)         customers#show
                      PATCH  /customers/:id(.:format)         customers#update
                      PUT    /customers/:id(.:format)         customers#update
                      DELETE /customers/:id(.:format)         customers#destroy
          login_index POST   /login(.:format)                 login#create
            new_login GET    /login/new(.:format)             login#new
   admins_login_index POST   /admins_login(.:format)          admins_login#create
     new_admins_login GET    /admins_login/new(.:format)      admins_login#new
               admins GET    /admins(.:format)                admins#index
                      POST   /admins(.:format)                admins#create
            new_admin GET    /admins/new(.:format)            admins#new
           edit_admin GET    /admins/:id/edit(.:format)       admins#edit
                admin GET    /admins/:id(.:format)            admins#show
                      PATCH  /admins/:id(.:format)            admins#update
                      PUT    /admins/:id(.:format)            admins#update
                      DELETE /admins/:id(.:format)            admins#destroy
                 cars GET    /cars(.:format)                  cars#index
                      POST   /cars(.:format)                  cars#create
              new_car GET    /cars/new(.:format)              cars#new
             edit_car GET    /cars/:id/edit(.:format)         cars#edit
                  car GET    /cars/:id(.:format)              cars#show
                      PATCH  /cars/:id(.:format)              cars#update
                      PUT    /cars/:id(.:format)              cars#update
                      DELETE /cars/:id(.:format)              cars#destroy
         reservations GET    /reservations(.:format)          reservations#index
                      POST   /reservations(.:format)          reservations#create
      new_reservation GET    /reservations/new(.:format)      reservations#new
     edit_reservation GET    /reservations/:id/edit(.:format) reservations#edit
          reservation GET    /reservations/:id(.:format)      reservations#show
                      PATCH  /reservations/:id(.:format)      reservations#update
                      PUT    /reservations/:id(.:format)      reservations#update
                      DELETE /reservations/:id(.:format)      reservations#destroy
                 root GET    /                                login#new


```

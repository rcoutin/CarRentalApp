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

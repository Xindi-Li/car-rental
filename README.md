# README

### Preconfigured admin: 

* Email: 123@123.com, 456@456.com, 789@789.com


* Password: 123

### Edge case:

#### Delete a car

when superadmin or admin tries to delete a car which is checked out then, it would failed to delete the car, if the car is just reserved, the reservation would be deleted along with the car, the same goes for the history reservations of the car.

#### Delete a customer

when superadmin or admin tries to delete a customer who checks out a car then, it would failed to delete the customer, if the customer just hold a reservation, the reservation would be deleted along with the customer, and the status of the car would change to available, the history reservations of the customer are deleted too.

### Time limitations

1. If the car is not picked up 30 minutes after the pickup time, next time the cutomer log in, he will see a notification on the welcome page (To see the notification, the customer has to log in again)
2. If the car is not returned in time, it will be the same as the first one.
3. **To test the these two feature, you have to make some requests at least every twenty to thirty minutes to prevent heroku from sleeping due to long-time idling. If heroku sleeps, the scheduler will not be triggerd on time.**

### Log in

1. Click "Login" in the home page.
2. Input the user login information.
3. If logging in successfully, the user will be redirected to the home page with different buttons visiable according to their authority. Otherwise, they will be asked to input login information again.

### Superadmin

A superadmin could manage admins and superadmins and have all the authority that an admin have.

#### Manage admins

When a superadmin login, he or she could manage admins via "Manage admins" button. A superadmin could create new admins, view the list of all the admins and their profiles.

##### create admin
* superadmin login -> manage admins -> new admin

##### destroy admin
* superadmin login -> manage admins -> delete

##### view details of an admin
* superadmin login -> manage admins -> view

#### Manage superadmins

##### create superadmin
* superadmin login -> manage superadmins -> new superadmins

##### view details of a superadmin
* superadmin login -> manage superadmins -> show


### Admin
An admin could manage admins, customers, cars and reservations. And he or she could also reserve or check out a car for a customer.

#### Manage admins

##### create admin
* admin login -> manage admins -> new admin

##### view details of an admin
* admin login -> manage admins -> view

#### Manage cars

##### create a car
* manage login -> manage cars -> new car

##### reserve a car for a customer
* manage login -> manage cars -> reserve

##### rent a car for a customer
* manage login -> manage cars -> rent

##### view details of a car
* manage login -> manage cars -> show

##### edit a car
* manage login -> manage cars -> edit

##### delte a car
* manage login -> manage cars -> delete

#### Manage customers

##### create a customer
* manage login -> manage customers -> new customer

##### view details of a customer
* manage login -> manage customers -> view

##### edit a customer
* manage login -> manage customers -> edit

##### delete a customer
* manage login -> manage customers -> delete

#### Manage reservations

##### view the list of reservation
* manage login -> manage reservations

##### modify a reservation
* manage login -> manage reservations -> modify

### Customer

#### use cars

##### search car

* customer loggin -> view cars -> search

##### view details of a car

* customer loggin -> view cars -> Show

##### reserve a car

* customer loggin -> view cars -> Reserve

##### rent a car

* customer loggin -> view cars -> rent

#### manage current reservation

##### checkout car

* customer login -> View current reservation -> checkout

##### return car

* customer login -> View current reservation -> return 

#### view personal checkout history
* customer login -> view checkout history

#### view personal profile
* customer login ->  Account -> Profile


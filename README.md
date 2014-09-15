# Boris Bikes

A second version of Boris Bikes pairing with [Toan]((https://github.com/yoshdog)). As we switched pairs (paired with Jenny for the first version which can be found [here](https://github.com/cmew3/Boris_Bikes_2))


Recreating the London Boris Bikes System.
------------

We are building a system that manages bikes that can be rented by users from docking stations and returned there at the end of the rental. The bikes can break while being used, in which case they will not be available for rental after they are returned. There is a garage that can fix broken bikes. A van is used to move broken bikes from the stations to the garage. It can also be used to take fixed bikes back to the station(s). The van, all stations and the garage have fixed capacity, so they cannot take more bikes that they can hold.

Built using the following Principles

* Test Driven Development
* Object-Oriented Programming
* Unit tests (no integration/feature testing yet)
* London style mocking and stubbing

How to run tests
----------
Tested using [rspec](https://github.com/rspec/rspec)

```shell
rspec
```
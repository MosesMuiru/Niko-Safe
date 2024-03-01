# the overall story

    under emergency either health or attacks you are able to send distress signals
    
    you should be able to insert you own team..
    if no distress signal is sent or no response is given
        follow up with a call
        stating you geolocation
         



## operations to the db

## user

create a user
read the users
update users
delete users

able to fetch user based on the his mobile number to check if the user exists
user has one to many relationship
    check if the user has a certain garget


## garget

create a garget
read all the gargets in the db
update a garget
check of if a garget is registered to a user
etc..

## rescue team

a user is able to enter numbers of recue team -> this are people who will response to his alert

  this may include people in the contact list


by default i have include an emergency message


## emergency and how it will occur

message -> call
this is to make sure that the distress signal has been sent


number must be verified and confirmed by the user
then it will be indicated as verified

this will happen with the use of an otp

# issue
Because "the lock" specifies tesla 1.8.0 and every version of at_ex depends on tesla ~> 1.2.1, the lock is incompatible with at_ex.
And because your app depends on the lock, no version of at_ex is allowed.
So, because your app depends on at_ex ~> 0.20.22, version solving failed.
** (Mix) Hex dependency resolution failed
# solution
to change the dependacies that were being used by at

# the overall story

    under emergency either health or attacks you are able to send distress signals
    
    you should be able to insert you own team..
    if no distress signal is sent or no response is given
        follow up with a call
        stating you geolocation -> not included in this module
        
    # why use sms and follow up call
    the only way to determin the other user has received the sms is by texting them, then 
    making a sure bet by placing a follow up call 
    
    more so this will be applicable in emergencies
    health 
# what is the expected rescue plan
    the only expected rescue plan is when you they call you back
    this is mostly applicable in health we assume that the place you are is a place where you are able to receive calls
# otherwise
    I made an assumption that you are at a place where you cannot pick your phone so as we can be able to track your location
    There for we assume your rescue team (in this case responders) will contact the legal authorities for this emergencies
    
    also we assume you added an emergency number when you were adding them in your system
# 
soon I will be able to get rid off some of the assumptions

         



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

---
number must be verified and confirmed by the user
then it will be indicated as verified

this will happen with the use of an otp
---

---
# let me take you through might thought process and maybe my vision --> si jaba
    so user enters details via ussd -- why use ussd_(mazee nilikuwa nataka challenge) basically i want to make this as offline as possible
    details entered via ussd
        1. Your name -> please a popular name that your reponders will get to know who it is automatically
        2. Your Garget id -> this is the unique id that comes with the garget
        3. phone numbers - this is a String comma of different numbers example 07XXX,07XXX
        this details are sent to you as a user
        also a sms with a # pin
        
        each user in your responder will recieve an sms saying that you have set to be responder
    
        
---
# issue
Because "the lock" specifies tesla 1.8.0 and every version of at_ex depends on tesla ~> 1.2.1, the lock is incompatible with at_ex.
And because your app depends on the lock, no version of at_ex is allowed.
So, because your app depends on at_ex ~> 0.20.22, version solving failed.
** (Mix) Hex dependency resolution failed
# solution
to change the dependacies that were being used by at

# so it is complicated to get the location of device based on ip address
    read this under 
    wifi position
    
    when you use ip address to determine the location you will get the location of the internet service provider
    apperntly you might be in kapsang(just a random place) then your ip location tracker reads that you are in Nairobi
    
    # solution
    either you talk to you service provider to allow you access the person ip
    or
    use an gps module
    
    # gps( global position system)
    uses setellite technology to determine the location 
    might be accurate but mostly it is 2D(latitude and longitude) the 3D (you add attidude)
    
## things to implement
help 
    a place where i will ask for help
    this will provide step by step guide on how to use this system

some analysis
    this will contain a page where all reported matters have been reported
    

how to implement the emergency system
    create a trigger function containing the following
        voice trigger
        sms dispatch
    this should either happen simultenously
## authenticatin
    when a user has login 
    a confirmation message is sent to his phone
    should contain the following
        1. your name    
        2. a unique moses password
        this is for login

    when registering, to view you details
        You enter your garget id
        enter the unique code sent via sms



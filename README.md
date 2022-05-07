# Circus

## Circus: Connecting you with on-campus freelancers.
*Welcome to the Circus, you clown 🤡*

At the Circus, Cornellians can post and purchase any jobs they would like to do or be done. For example, a user can offer a haircut for $25 and another user could purchase that service. After creating an account, users can browse for services they may be interested in in an Etsy-style homepage, and contact, utilizing the filters we have implemented. You can also post your own listings and become a provider account!

The gig industry has become exceptionally popular in recent times with the rise of companies such as Uber, Lyft, DoorDash, Fiverr, and such, and we hope to bring this to Cornell. It is a great way for sellers to make some money, while users can get something they need done cheaply.


## The Frontend
https://github.com/bonytoni/freelance-marketplace-frontend

*Login*  
Opening the app, you are met with a signup or login page. Input your basic information, sign in, and you will be taken to the home page.  
![Welcome](https://user-images.githubusercontent.com/52147838/167238431-e6fe98cd-db7a-40f8-8b34-722b4ffcaaf5.jpg)
![Signup](https://user-images.githubusercontent.com/52147838/167238436-ab35ee73-af77-4d12-8c98-1dffb97e9033.jpg)

*Hompage* 
In the homepage, you will see all the listings that you or other users have posted. Each listing is a freelance service with a picture and all the information you need to know about it.  
![Homepage](https://user-images.githubusercontent.com/52147838/167238441-6e2096a8-a2d1-4ac5-9e45-2a7e52bc783e.jpg)
![Listing](https://user-images.githubusercontent.com/52147838/167238448-afd9236d-285d-4683-bc02-9d3646f17034.jpg)

*User Profile*  
On the user profile, you can see your profile and the listings you are selling. You can also add your own listings, and see the ones you bought!  
![Profile](https://user-images.githubusercontent.com/52147838/167238463-82f18043-7dd7-4677-8195-d98cd12359a7.jpg)
![Post](https://user-images.githubusercontent.com/52147838/167238473-daa5b2ae-d6e5-46c3-a216-cee0f2e8b391.jpg)
![History](https://user-images.githubusercontent.com/52147838/167238488-021da3f7-47ae-406d-81a3-d0ff564c4aeb.jpg)



## The Backend
https://github.com/jjennifergu/freelance-marketplace-backend

We wrote routes to implement creating, editing, removing, purchasing, and getting listings, only accessible to users who are authenticated. Furthermore, related to users, we wrote routes to create, edit, and getting users (accounts). Authentication is used throughout. To make things easier, we also implemented different ways to getting specific users as well, by session_token, and by username.

We maintain a Users table and a Listings table. A user could be a seller or a buyer. A seller has a one-to-many relationship with listings, as a listing can only have one seller. A buyer has a many-to-many relationship with listings, as a listing could be purchased by multiple buyers and a buyer can purchase multiple listings. Our association table enables the many-to-many relationship. With these relationships established we are also able to allow users to purchase listings as well. 


## The Requirements
1. Autolayout, Snapkit, or SwiftUI  
Used NSAutolayout to constrain views and design the user interface of the app

2. At least one list view (TableView, CollectionView or SwiftUI List)  
Used UICollectionViews to display listings along with UITableViews to display personally created services and purchased listings

3. Navigation between at least one viewController  
Used UINavigationController to navigate between multiple screens. Presented screens to offer pretty designs

4. Integrate at least one API (probably what your backend members provide you with, but you are free to integrate external APIs)  
Integrates custom built API from the backend to store all the listings and services and retrieve them on the front end


## Comments
Due to the large number of images, you may experience some delays in nagivating Circus. Furthermore, we encode images to base-64 strings and store them in the backend, each of which are extremely long. In the future, we could implement a faster way to store and retrieve images.


## The Team
**Clara Lee** cl874: Product Designer  
**Jennifer Gu** jg2368: Full Stack Developer  
**Tony Chen** tc448: Frontend Developer  
**Benjamin Tang** bt283: Backend Developer  
**Lily Pham** lnp35: Backend Developer  

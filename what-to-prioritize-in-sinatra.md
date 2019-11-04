# What to Prioritize in the Sinatra Section

## DO Prioritize:

**ORMs and ActiveRecord Unit: Migrations, CRUD Intro, and Associations**

After this unit you should be able to:
- Understand that migrations are what we write to make changes to our database.
- Explain when the `schema` changes.
- Explain and demonstrate in `tux` how we access objects through ActiveRecord associations defined in our models. (Ex: `current_user.posts` — will return an array of posts that belong to the `current_user` object. Where is the `.posts` method defined?)

**Rack Unit: How the Internet Works, Request/Response Flow, Routes**

Double down on
- Difference between `get`, `post`, `patch`, and `delete` requests and responses.
- How "Dynamic URL Routes" work.
- Practice solidifying your understanding of the Request/Response Flow by drawing your own diagrams of this flow

**MVC and Forms Unit: Model, View, Controller (MVC)**

Get comfortable with why we use this file structure, as MVC will be present in most applications. The MVC structure allows us to separate our application's concern, ultimately optimizing functionality and code organization. A popular analogy that is used is to think about the MVC file structure as a restaurant.

  1. **Model (Database):** Think of the "model" as a the kitchen where the chef is preparing the food, in our case ActiveRecord could be considered the chef and the food is our data.

  2. **View (The Frontend of our Application):** Think of the view as the plate of food that the customer finally sees, this could be considered the "frontend" of our application.

  3. **Controller (Intermediary for the Model and View):** Think of the controller as the waiter goes back and forth between the kitchen and the customer's table. The waiter delivers the plate of food from the kitchen to the customer (end user/frontend) and returns back to the kitchen at the customers request — the plate/customer could be considered the "view" in this analogy.

At the end of this unit you should be able to explain the MVC flow in your own words.

**ActiveRecord Unit: CRUD, Authentication, ActiveRecord Associations**

  - **"Sinatra ActiveRecord CRUD" Lab:** Be sure to get tons of practice with building out Create, Read, Update, and Delete (CRUD) functionality in an application. Not only will CRUD be the basis for the functionality of your Sinatra Final Project, but CRUD is also the base functionality for a lot of the apps we use today like note apps and social media apps like Instagram.

  Be able to answer questions like:

      1. What is the difference between rendering vs. redirecting?
      2. Where do the instance variables in our view files come from — where are they declared and how do we have access to them?


  - **"User Authentication in Sinatra" + "Securing Passwords in Sinatra" Labs:** Double down on these labs to confirm your understanding of the authentication flow in Sinatra. Check for understanding by answering these questions:

      1. What is a `session`? How do I enable it in my application and why?
        * the time between when someone logs in to and logs out of your app
        * The action of logging in is the simple action of storing a user's ID in the session hash
        * The action of 'logging out' is really just the action of clearing all of the data, including the user's ID, from the session hash.
        * in the same controller route in which we create a new user, we set the session[:user_id] equal to the new user's ID, effectively logging them in.
        * enable :sessions in ApplicationController
        * 

      2. What are the basics of ActiveRecord's `has_secure_password` method?
        * ActiveRecord macro that works in conjunction with bcrypt gem and gives us all of those abilities in a secure way that doesn't actually store the plain text password in the database.
        * even though our database has a column called password_digest, we still access the attribute of password. This is given to us by has_secure_password
        * we won't be able to save this to the database unless our user filled out the password field. Calling user.save will return false if the user can't be persisted.

      3. What does the `.authenticate` method do and how is it connected to the `has_secure_password` method?
        * validates password match on User model
        * metaprogramming - by adding `has_secure_password` we told Ruby to add an `.authenticate` method to our class
          1. Takes a String as an argument e.g. i_luv@byron_poodle_darling
          2. It turns the String into a salted, hashed version (76776516e058d2bf187213df6917a7e)
          3. It compares this salted, hashed version with the user's stored salted, hashed password in the database
          4. If the two versions match, authenticate will return the User instance; if not, it returns false
      4. Why do we use the `bcrypt` gem and what is the significance of adding the `password_digest` column to the `User` model in the database?
        * BCrypt will store a salted, hashed version of our users' passwords in our database in a column called password_digest.
        * password encryption: the act of scrambling a user's password into a super-secret code and storing a de-crypter that will be able to match up a plaintext password entered by a user with the encrypted version stored in a database.
        * to implement running the passwords through a hashing algorithm. A hashing algorithm manipulates data in such a way that it cannot be un-manipulated. This is to say that if someone got a hold of the hashed version of a password, they would have no way to turn it back into the original. In addition to hashing the password, we'll also add a "salt". A salt is simply a random string of characters that gets added into the hash. That way, if two of our users use the password "fido", they will end up with different hashes in our database.

## DON'T Spend _Too_ Much Time Here:

**SQL (Structured Query Language) Unit**

Let's begin by saying SQL is an important unit. This unit is basically a primer on how we read the queries to our database that will be displayed in our console when our program is running. Being able to read these queries becomes important when we want to do things like debug or collect context clues for an error related to our database. BUT spoiler alert: ActiveRecord will "write" and "read" SQL for us. This unit is dedicated to priming us to the power of database queries and ActiveRecord, so no need to deep dive here _but_ definitely familiarize yourself with SQL queries — being able to read this language comes in handy when investigating the behavior of your database.

**ORMs Sub-Unit**

While ORM is an important concept, at this point it's sufficient to understand it _at a high level_. This sub-unit can get really abstract and it's easy to get lost in the weeds here. Just think of this sub-unit as us laying down the ground work to introduce you to the ActiveRecord magic.

**HTML Continued && CSS Continued Units**

WE KNOW...these units are so fun! This is a _really_ exciting time in the curriculum where we finally spend sometime in the browser. In the CLI section we were in the console for so long that it's really tempting to spend a lot of time here on all the front-end fun. By all means don't skip this section as we are building projects as portfolio pieces and we want them to shine! But at this stage, it would be more wise to invest your time and energy resources in the units above. You can always dive deeper into HTML and CSS later in or after the program.

# Recipe Box - Sinatra App

A web application designed for users to build their own recipe collections.
* Users sign up to create an account.
* Once logged in to the app, users can create, edit, and delete their recipes and view the recipes of other users.
* Users can edit their account information and delete their account.
* Users can also search for recipes by ingredient name, recipe name, or recipe course via a search box in the navigation bar.

## Installation & Setup

* Clone the Recipe Box repo onto your computer
  * Go to 'https://github.com/jamieberrier/recipe-box'
  * Click on the green **Clone or download** button
  * Make sure **Clone with HTTPS** is displayed (if not, click the 'use HTTPS' link)
  * Click the **clipboard icon**
  * In your terminal, type `git clone` and then paste the copied URL.
* Type `cd recipe-box` to change the current working directory
* Run `bundle install` to load the Ruby gems and dependencies

## Usage

* Type `shotgun` in your terminal to run the Recipe Box web application on your local machine
* Open your browser and navigate to http://127.0.0.1:9393
* Once the welcome page loads, click **Sign Up** to create a new user account and login
  * Or click **Log In** to log in as an existing user from the users in 'db/seeds.rb'
> _To stop the shotgun session and exit, type `CTRL + C` in your terminal_

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jamieberrier/recipe-box. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

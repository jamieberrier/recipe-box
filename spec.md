# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
      - Used Corneal gem
- [x] Use ActiveRecord for storing information in a database
      - gems: activerecord, sinatra-activerecord, rake, sqlite3
      - set up a connection to database in environment.rb
        - ActiveRecord::Base.establish_connection(
          :adapter => "sqlite3",
          :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
          )
      - used Rakefile to run ActiveRecord migrations
      -
- [x] Include more than one model class (e.g. User, Post, Category)
      - User, Recipe, Ingredient, RecipeIngredient
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
      - User has_many :recipes
      - Recipe has_many :recipe_ingredients
      - Recipe has_many :ingredients, through: :recipe_ingredients
      - Ingredient has_many :recipe_ingredients
      - Ingredient has_many :recipes, through: :recipe_ingredients
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
      - Recipe belongs_to :user
      - RecipeIngredient belongs_to :ingredient
      - RecipeIngredient belongs_to :recipe
- [ ] Include user accounts with unique login attribute (username or email)
- [ ] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- [ ] Ensure that users can't modify content created by other users
- [ ] Include user input validations
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message

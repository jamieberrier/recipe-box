# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app  
      - Corneal gem
- [x] Use ActiveRecord for storing information in a database  
      - gems: activerecord, sinatra-activerecord, rake, sqlite3  
      - set up a connection to database in environment.rb  
          * ActiveRecord::Base.establish_connection(
          :adapter => "sqlite3",
          :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
          )  
      - used Rakefile to run ActiveRecord migrations  
      - ActiveRecord methods: new, save, create
- [x] Include more than one model class (e.g. User, Post, Category)  
      - User, Recipe, Ingredient, RecipeIngredient, Course
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
- [x] Include user accounts with unique login attribute (username or email)  
      - unique email  
        * User model  
          + validates :email, :display_name, presence: true, uniqueness: { case_sensitive: false }
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying  
      - RecipesController CRUD routes  
        * CREATE  
          + get "/recipes/new"  
          + post "/recipes"  
        * READ  
          + get "/recipes"  
            - all recipes  
          + get "/recipes/:slug"  
            - one recipe  
        * UPDATE  
          + get "/recipes/:slug/edit"  
          + patch "/recipes/:slug"  
        * DESTROY  
          + delete "/recipes/:slug/delete"
- [x] Ensure that users can't modify content created by other users  
      - in UPDATE routes and recipes/show view  
        * helper method: authorized_to_edit?(recipe)  
          + current_user == recipe.user
- [x] Include user input validations  
      - ActiveRecord validations  
        * Recipe model  
          + validates :user, presence: true  
          + validates :name, :total_time, :cook_time, :instructions, :course_id, presence: true  
          + validates :name, uniqueness: { case_sensitive: false }  
        * User model  
          + validates :email, :display_name, presence: true, uniqueness: { case_sensitive: false }
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)  
      - gem: sinatra-flash  
      - layout.erb: styled_flash helper method  
      - routes: flash[:error], flash[:success], flash[:warning], flash[:info]
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code  
      - short description  
      - install instructions  
      - contributors guide  
      - link to the license  

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message

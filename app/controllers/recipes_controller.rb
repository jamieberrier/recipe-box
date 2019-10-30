class RecipesController < ApplicationController
  # READ -- index route for all recipes
  get "/recipes" do
    if logged_in?
      @recipes = Recipe.order(:name)
      erb :"/recipes/index"
    else
      redirect_to("/", :error, "You must be logged in to view recipes")
    end
  end
  # CREATE -- render form to create new recipe
  get "/recipes/new" do
    if logged_in?
      erb :"/recipes/new"
    else
      redirect_to("/", :error, "You must be logged in to create a new recipe")
    end
  end
  # CREATE -- post route to create new recipe
  post "/recipes" do
    if logged_in?
      # check user entered at least 1 ingredient (if first ingredient name is blank)
      if params[:recipe][:ingredients].first["name"].blank?
        redirect_to("/recipes/new", :error, "Must include at least 1 ingredient")
      else # user entered at least 1 ingredient
        @recipe = Recipe.new(user_id: current_user.id, name: params[:recipe][:name], course_id: params[:recipe][:course_id], description: params[:recipe][:description], total_time: params[:recipe][:total_time], cook_time: params[:recipe][:cook_time], instructions: params[:recipe][:instructions], image_url: params[:recipe][:image_url])
        if @recipe.save # valid inputs, add ingredients
          add_ingredients(params[:recipe][:ingredients])
          redirect_to("/users/#{@recipe.user.slug}", :success, "Successfully created recipe!")
        else # validation errors
          redirect_to("/recipes/new", :error, "Creation failure: #{@recipe.errors.full_messages.to_sentence}")
        end
      end
    end
  end
  # READ -- show route for single recipe (dynamic)
  get "/recipes/:slug" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      erb :"/recipes/show"
    else
      redirect_to("/", :error, "You must be logged in to view a recipe")
    end
  end
  # UPDATE -- render form to edit a recipe
  get "/recipes/:slug/edit" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])

      if authorized_to_edit?(@recipe)
        erb :"/recipes/edit"
      else # not authorized to edit
        redirect_to("/recipes", :error, "Not yours to edit!")
      end
    else # not logged in
      redirect_to("/", :error, "You must be logged in to edit a recipe")
    end
  end
  # UPDATE -- patch route to update existing recipe
  patch "/recipes/:slug" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])

      if authorized_to_edit?(@recipe)
        if @recipe.update(params[:recipe]) # valid recipe inputs, update existing ingredients
          params[:ingredients].each.with_index do |ingredient, index|
            if ingredient[:name].blank? # user deleted ingredient
              @recipe.recipe_ingredients[index].delete
            else # update ingredient name and amount
              @recipe.ingredients[index].update(name: ingredient[:name])
              @recipe.recipe_ingredients[index].update(ingredient_amount: ingredient[:ingredient_amount])
            end
          end
          # check for New Ingredients added
          add_ingredients(params[:new_ingredients])
          redirect_to("/recipes/#{@recipe.slug}", :success, "Recipe successfully updated!")
        else # validation errors
          redirect_to("/recipes/#{@recipe.slug}/edit", :error, "Edit failure: #{@recipe.errors.full_messages.to_sentence}")
        end
      else # not authorized to edit
        redirect_to("/recipes", :error, "Not yours to edit!")
      end
    else # not logged in
      redirect_to("/", :error, "You must be logged in to edit a recipe")
    end
  end
  # DESTROY -- delete route to delete an existing recipe
  delete "/recipes/:slug/delete" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      if authorized_to_edit?(@recipe)
        @recipe.destroy
        redirect_to("/users/#{@recipe.user.slug}", :success, "Recipe deleted.")
      else # not current user's recipe
        redirect_to("/recipes", :error, "Not yours to delete!")
      end
    else # not logged in
      redirect_to("/", :error, "Must be logged in to delete!")
    end
  end
  # Search recipe course, name, and ingredients
  get "/search" do
    if logged_in?
      @recipes = []
      # search recipe course
      Course.all.each do |course|
        if params[:search].downcase == course.name.downcase
          # The find_each method retrieves records in batches and then yields each one to the block
          Recipe.all.where(course_id: course.id).find_each do |recipe|
            @recipes << recipe
          end
        end
      end # search recipe course
      # if search term is not a course
      if @recipes.empty?
        # search recipe names
        @recipes = Recipe.search_name(params[:search])
        # search ingredients
        Recipe.all.each do |recipe|
          if !@recipes.ids.include?(recipe.id)
            recipe.ingredients.where('name like :pat', pat: "%#{params[:search]}%").find_each do |i|
              @recipes << recipe
            end
          end
        end # search ingredients
      end
      erb :"/recipes/results"
    else # not logged in
      redirect_to("/", :error, "Must be logged in to search!")
    end
  end

  helpers do
    def add_ingredients(ingredients)
      ingredients.each do |ingredient|
        if !ingredient[:name].blank? # user entered an ingredient name
          i = Ingredient.find_by(name: ingredient[:name])
          if i.nil? # ingredient does not exist, create and add ingredient
            @recipe.ingredients << Ingredient.create(name: ingredient[:name])
          else # ingredient exists, add ingredient
            @recipe.ingredients << i
          end
          # update ingredient amount
          @recipe.recipe_ingredients.last.update(ingredient_amount: ingredient[:ingredient_amount])
        end
      end
    end
  end
end

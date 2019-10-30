class RecipesController < ApplicationController
  # READ
  get "/recipes" do
    if logged_in?
      @recipes = Recipe.order(:name)
      erb :"/recipes/index"
    else
      redirect_to("/", :error, "You must be logged in to view recipes")
    end
  end
  # CREATE
  get "/recipes/new" do
    if logged_in?
      erb :"/recipes/new"
    else
      redirect_to("/", :error, "You must be logged in to create a new recipe")
    end
  end
  # CREATE
  post "/recipes" do
    @recipe = Recipe.new(user_id: current_user.id, name: params[:recipe][:name], course_id: params[:recipe][:course_id], description: params[:recipe][:description], total_time: params[:recipe][:total_time], cook_time: params[:recipe][:cook_time], instructions: params[:recipe][:instructions], image_url: params[:recipe][:image_url])
    if @recipe.save
      params[:recipe][:ingredients].each do |ingredient|
        if !ingredient[:name].blank?
          i = Ingredient.find_by(name: ingredient[:name])
          if i.nil? # create ingredient
            @recipe.ingredients << Ingredient.create(name: ingredient[:name])
          else
            @recipe.ingredients << i
          end
          @recipe.recipe_ingredients.last.update(ingredient_amount: ingredient[:ingredient_amount])
        end
      end
      redirect_to("/users/#{@recipe.user.slug}", :success, "Successfully created recipe!")
    else #validation errors
      redirect_to("/recipes/new", :error, "Creation failure: #{@recipe.errors.full_messages.to_sentence}")
    end
  end
  # READ
  get "/recipes/:slug" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      erb :"/recipes/show"
    else
      redirect_to("/", :error, "You must be logged in to view a recipe")
    end
  end
  # UPDATE
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
  # UPDATE
  patch "/recipes/:slug" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])

      if authorized_to_edit?(@recipe)
        if @recipe.update(params[:recipe])
          params[:ingredients].each.with_index do |ingredient, index|
            if ingredient[:name].blank?
              @recipe.recipe_ingredients[index].delete
            else
              @recipe.ingredients[index].update(name: ingredient[:name])
              @recipe.recipe_ingredients[index].update(ingredient_amount: ingredient[:ingredient_amount])
            end
          end
          # New Ingredients added
          params[:new_ingredients].each do |new_ingredient|
            if !new_ingredient[:name].blank?
              i = Ingredient.find_by(name: new_ingredient[:name])
              if i.nil? # create ingredient
                @recipe.ingredients << Ingredient.create(name: new_ingredient[:name])
              else # add ingredient
                @recipe.ingredients << i
              end
              # update ingredient amount
              @recipe.recipe_ingredients.last.update(ingredient_amount: new_ingredient[:ingredient_amount])
            end
          end # end add new ingredients
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
  # DESTROY
  delete "/recipes/:slug/delete" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      if current_user.id == @recipe.user_id
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
          Recipe.all.where('course_id is :pat', :pat => course.id).find_each do |recipe|
            @recipes << recipe
          end # find_each
        end # if
      end # each
      # if search term is not a course
      if @recipes.empty?
        # search recipe names
        @recipes = Recipe.search_name(params[:search])
        # search ingredients
        Recipe.all.each do |recipe|
          if !@recipes.ids.include?(recipe.id)
            recipe.ingredients.where('name like :pat', :pat => "%#{params[:search]}%").find_each do |i|
              @recipes << recipe
            end # find_each
          end # if
        end # each
      end # if @recipes.empty?
      erb :"/recipes/results"
    else # not logged in
      redirect_to("/", :error, "Must be logged in to search!")
    end # logged_in?
  end # search
end

class RecipesController < ApplicationController

  # GET: /recipes
  get "/recipes" do
    if logged_in?
      @recipes = Recipe.all
      erb :"/recipes/index"
    else
      flash[:error] = "You must be logged in to view recipes"
      homepage
    end
  end

  # GET: /recipes/new
  # render view to get user input for number of ingredients to use when generating new recipe form
  get "/recipes/new" do
    if logged_in?
      erb :"/recipes/number_of_ingredients"
    else
      flash[:error] = "You must be logged in to create a new recipe"
      homepage
    end
  end

  # save user input for number of ingredients to pass when rendering recipes/new
  post "/recipes/new" do
    @num = params[:num].to_i
    erb :"/recipes/new"
  end

  # POST: /recipes
  post "/recipes" do
    @recipe = Recipe.new(user_id: current_user.id, name: params[:recipe][:name], course: params[:recipe][:course], description: params[:recipe][:description], total_time: params[:recipe][:total_time], cook_time: params[:recipe][:cook_time], instructions: params[:recipe][:instructions], image_url: params[:recipe][:image_url])
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
      flash[:success] = "Successfully created recipe!"
      redirect "/users/#{@recipe.user.slug}"
    else
      flash[:error] = "Creation failure: #{@recipe.errors.full_messages.to_sentence}"
      redirect "/recipes/new"
    end
  end

  get "/search" do
    if logged_in?
      @recipes = Recipe.search(params[:search])

      Recipe.all.each do |recipe|
        if !@recipes.ids.include?(recipe.id)
          recipe.ingredients.where('name like :pat', :pat => "%#{params[:search]}%").find_each do |i|
            @recipes << recipe
          end
        end
      end
      erb :"/recipes/results"
    else
      flash[:error] = "Must be logged in to search!"
      homepage
    end
  end

  # GET: /recipes/5
  get "/recipes/:slug" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])
      erb :"/recipes/show"
    else
      flash[:error] = "You must be logged in to view a recipe"
      homepage
    end
  end

  # GET: /recipes/5/edit
  get "/recipes/:slug/edit" do
    if logged_in?
      @recipe = Recipe.find_by_slug(params[:slug])

      if authorized_to_edit?(@recipe)
        erb :"/recipes/edit"
      else
        flash[:error] = "Not yours to edit!"
        redirect "/recipes"
      end
    else
      flash[:error] = "You must be logged in to edit a recipe"
      homepage
    end
  end

  # PATCH: /recipes/5
  patch "/recipes/:slug" do
    @recipe = Recipe.find_by_slug(params[:slug])

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
      end
      flash[:success] = "Recipe successfully updated!"
      redirect "/recipes/#{@recipe.slug}"
    else
      flash[:error] = "Edit failure: #{@recipe.errors.full_messages.to_sentence}"
      redirect "/recipes/#{@recipe.slug}/edit"
    end
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:slug/delete" do
    delete_recipe!
  end

  # if a user tries to delete another user's recipe via URL
  get "/recipes/:slug/delete" do
    delete_recipe!
  end

  helpers do
    def delete_recipe!
      if logged_in?
        @recipe = Recipe.find_by_slug(params[:slug])
        if current_user.id == @recipe.user_id
          @recipe.destroy
          flash[:success] = "Recipe deleted."
          redirect "/users/#{@recipe.user.slug}"
        else
          flash[:error] = "Not yours to delete!"
          redirect "/recipes"
        end
      else
        flash[:error] = "Must be logged in to delete!"
        homepage
      end
    end
  end
end

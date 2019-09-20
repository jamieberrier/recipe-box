class RecipesController < ApplicationController

  # GET: /recipes
  get "/recipes" do
    @recipes = Recipe.all
    erb :"/recipes/index"
  end

  # GET: /recipes/new
  get "/recipes/new" do
    erb :"/recipes/new"
  end

  # POST: /recipes
  post "/recipes" do
    if @recipe = Recipe.create(user_id: current_user.id, name: params[:recipe][:name], description: params[:recipe][:description], total_time: params[:recipe][:total_time], cook_time: params[:recipe][:cook_time], instructions: params[:recipe][:instructions], image_url: params[:recipe][:image_url], course: params[:recipe][:course])
      count = 0
      params[:recipe][:ingredients].each do |ingredient|
        if !ingredient[:name].blank?
          @recipe.ingredients << Ingredient.create(name: ingredient[:name], food_group: ingredient[:food_group])
          @recipe.recipe_ingredients[count].update(ingredient_amount: ingredient[:ingredient_amount])
          count += 1
        end
      end
      redirect "/recipes/#{@recipe.id}"
    else
      redirect "/recipes/new"
    end
  end

  # GET: /recipes/5
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    #binding.pry
    erb :"/recipes/show"
  end

  # GET: /recipes/5/edit
  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])

    if authorized_to_edit?(@recipe)
      erb :"/recipes/edit"
    else
      flash[:error] = "Not yours to edit!"
      redirect "/recipes"
    end
  end

  # PATCH: /recipes/5
  patch "/recipes/:id" do
    redirect "/recipes/:id"
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:id/delete" do
    @recipe = Recipe.find(params[:id])
    if logged_in? && current_user.id == @recipe.user_id
      @recipe.destroy
      flash[:message] = "Recipe deleted."
      redirect "/users/#{@recipe.user_id}"
    else
      redirect "/recipes"
    end
  end
end

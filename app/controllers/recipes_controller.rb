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
    @recipe = Recipe.new(user_id: current_user.id, name: params[:recipe][:name], course: params[:recipe][:course], description: params[:recipe][:description], total_time: params[:recipe][:total_time], cook_time: params[:recipe][:cook_time], instructions: params[:recipe][:instructions], image_url: params[:recipe][:image_url])
    if @recipe.save
      count = 0
      params[:recipe][:ingredients].each do |ingredient|
        if !ingredient[:name].blank?
          @recipe.ingredients << Ingredient.create(name: ingredient[:name], food_group: ingredient[:food_group])
          @recipe.recipe_ingredients[count].update(ingredient_amount: ingredient[:ingredient_amount])
          count += 1
        end
      end
      flash[:notice] = "Successfully created recipe!"
      redirect "/recipes/#{@recipe.id}"
    else
      flash[:error] = "Creation failure: #{@recipe.errors.full_messages.to_sentence}"
      redirect "/recipes/new"
    end
  end

  # GET: /recipes/5
  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])

    if @recipe.update(name: params[:recipe][:name], description: params[:recipe][:description], total_time: params[:recipe][:total_time], cook_time: params[:recipe][:cook_time], instructions: params[:recipe][:instructions], image_url: params[:recipe][:image_url], course: params[:recipe][:course])
      count = 0
      params[:recipe][:ingredients].each do |ingredient|
        if !ingredient[:name].blank?
          @recipe.ingredients[count].update(name: ingredient[:name], food_group: ingredient[:food_group])
          @recipe.recipe_ingredients[count].update(ingredient_amount: ingredient[:ingredient_amount])
          count += 1
        end
      end
      flash[:message] = "Recipe successfully updated!"
      redirect "/recipes/#{@recipe.id}"
    else
      flash[:error] = "Edit failure: #{@recipe.errors.full_messages.to_sentence}"
      redirect "/recipes/#{@recipe.id}/edit"
    end
  end

  # DELETE: /recipes/5/delete
  delete "/recipes/:id/delete" do
    delete_recipe!
  end

  # if a user tries to delete another user's recipe via URL
  get "/recipes/:id/delete" do
    delete_recipe!
  end
end

class IngredientsController < ApplicationController

  # GET: /ingredients
  get "/ingredients" do
    erb :"/ingredients/index.html"
  end

  # GET: /ingredients/new
  get "/ingredients/new" do
    erb :"/ingredients/new.html"
  end

  # POST: /ingredients
  post "/ingredients" do
    redirect "/ingredients"
  end

  # GET: /ingredients/5
  get "/ingredients/:id" do
    erb :"/ingredients/show.html"
  end

  # GET: /ingredients/5/edit
  get "/ingredients/:id/edit" do
    erb :"/ingredients/edit.html"
  end

  # PATCH: /ingredients/5
  patch "/ingredients/:id" do
    redirect "/ingredients/:id"
  end

  # DELETE: /ingredients/5/delete
  delete "/ingredients/:id/delete" do
    redirect "/ingredients"
  end
end

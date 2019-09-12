class UsersController < ApplicationController

  # GET: /users/new
  get "/signup" do
    if !logged_in?
      erb :"/users/new"
    else
      redirect "/users/#{@user.id}"
    end
  end

  # POST: /users
  post "/signup" do
    @user = User.create(params[:user])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end

  get "/login" do
    if !logged_in?
      erb :"/users/login"
    else
      redirect "/users/#{current_user.id}"
    end
  end

  post "/login" do
    login
  end

  get "/logout" do
    logout!
  end

  # GET: /users/5
  # use slug instead of id
  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"/users/show"
  end

  # GET: /users/5/edit
  # If user wants to edit their profile
  get "/users/:id/edit" do
    erb :"/users/edit"
  end

  # PATCH: /users/5
  # If user wants to edit their profile
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  # If user wants to delete their profile
  delete "/users/:id/delete" do
    redirect "/users"
  end
end

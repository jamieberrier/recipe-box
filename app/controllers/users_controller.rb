class UsersController < ApplicationController

  # GET: /users/new
  get "/signup" do
    if logged_in?
      redirect "/users/#{@user.id}"
    else
      erb :"/users/new"
    end
  end

  # POST: /users
  post "/users" do
    @user = User.find_by(email: params[:user][:email])
    if @user
      flash[:notice] = "User already exists, please log in"
      redirect "/login"
    else
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Successfully signed up!"
        redirect "/users/#{@user.slug}"
      else
        flash[:error] = "Signup failure: #{@user.errors.full_messages.to_sentence}"
        redirect "/signup"
      end
    end

  end

  get "/login" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    login
  end

  get "/logout" do
    logout!
  end

  # GET: /users/5
  #! use slug instead of id
  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  # GET: /users/5/edit
  # If user wants to edit their profile
  get "/users/:slug/edit" do
    erb :"/users/edit"
  end

  # PATCH: /users/5
  # If user wants to edit their profile
  patch "/users/:slug" do
    redirect "/users/:slug"
  end

  # DELETE: /users/5/delete
  # If user wants to delete their profile
  delete "/users/:slug/delete" do
    redirect "/users"
  end
end

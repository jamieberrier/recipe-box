class UsersController < ApplicationController

  # GET: /users/new
  get "/signup" do
    if logged_in?
      redirect "/users/#{@user.id}"
    else
      erb :"/users/new"
    end
  end

  post "/users" do
    @user = User.find_by(email: params[:user][:email])
    if @user
      redirect_to("/login", :warning, "User already exists, please log in")
    else
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect_to("/users/#{@user.slug}", :success, "Successfully signed up!")
      else
        redirect_to("/signup", :error, "Signup failure: #{@user.errors.full_messages.to_sentence}")
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
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
       session[:user_id] = @user.id
       redirect_to("/users/#{@user.slug}", :info, "Welcome #{@user.display_name}!")
    elsif !@user
      redirect_to("/login", :error, "Incorrect email address...<a href='/signup'>Sign Up?</a>")
    else @user && !@user.authenticate(params[:user][:password])
      redirect_to("/login", :error, "Incorrect password")
    end
  end

  get "/logout" do
    session.clear
    redirect_to("/", :info, "You are logged out!")
  end

  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show"
    else
      redirect_to("/", :error, "Must be logged in to view a user's recipes")
    end
  end

  # If user wants to edit their profile
  get "/users/:slug/edit" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])

      if @user == current_user
        erb :"/users/edit"
      else
        redirect_to("/", :error, "Not yours to edit!")
      end
    else
      redirect_to("/", :error, "Must be logged in to access!")
    end
  end

  # If user wants to edit their profile
  patch "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if @user == current_user
        # if successfully update display_name and email, check for new_password
        if @user.update(display_name: params[:user][:display_name], email: params[:user][:email])
          # only update password if params[:new_password] is not blank
          if !params[:user][:new_password].blank?
            @user.update(password: params[:user][:new_password])
          end
          redirect_to("/users/#{@user.slug}", :success, "Profile successfully updated!")
        else
          redirect_to("/users/#{@user.slug}/edit", :error, "Edit failure: #{@user.errors.full_messages.to_sentence}")
        end
      else
        redirect_to("/", :error, "Not yours to edit!")
      end
    else
      redirect_to("/", :error, "Must be logged in to edit profile!")
    end
  end

  # If user wants to delete their profile
  delete "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    if logged_in? && current_user == @user
      @user.destroy
      redirect_to("/", :success, "User profile deleted.")
    else
      redirect_to("/", :error, "Not yours to delete!")
    end
  end
end

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
      flash[:warning] = "User already exists, please log in"
      redirect "/login"
    else
      @user = User.new(params[:user])
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully signed up!"
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
    @user = User.find_by_slug(params[:slug])

    if logged_in? && @user == current_user
      erb :"/users/edit"
    else
      flash[:error] = "Not yours to edit!"
      redirect "/recipes"
    end
  end

  # PATCH: /users/5
  # If user wants to edit their profile
  patch "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    # if successfully update display_name and email, check for new_password
    if @user.update(display_name: params[:user][:display_name], email: params[:user][:email])
      # only update password if params[:new_password] is not blank
      if !params[:user][:new_password].blank?
        @user.update(password: params[:user][:new_password])
        flash[:success] = "Profile successfully updated!"
        redirect "/users/#{@user.slug}"
      else
        flash[:success] = "Profile successfully updated!"
        redirect "/users/#{@user.slug}"
      end
    else
      flash[:error] = "Edit failure: #{@user.errors.full_messages.to_sentence}"
      redirect "/users/#{@user.slug}/edit"
    end
  end

  # DELETE: /users/5/delete
  # If user wants to delete their profile
  delete "/users/:slug/delete" do
    delete_user!
  end

  get "/users/:slug/delete" do
    delete_user!
  end

  helpers do
    def delete_user!
      @user = User.find_by_slug(params[:slug])
      if logged_in? && current_user == @user
        @user.destroy
        flash[:success] = "User profile deleted."
        redirect "/"
      else
        flash[:error] = "Not yours to delete!"
        redirect "/users/#{@user.slug}"
      end
    end
  end # end helpers
end

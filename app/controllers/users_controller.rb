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
    @user = User.find_by(email: params[:user][:email])

    if @user && @user.authenticate(params[:user][:password])
       session[:user_id] = @user.id
       flash[:info] = "Welcome #{@user.display_name}!"
       redirect "/users/#{@user.slug}"
    elsif !@user
      flash[:error] = "Incorrect email address...<a href='/signup'>Sign Up?</a>"
      redirect "/login"
    else @user && !@user.authenticate(params[:user][:password])
      flash[:error] = "Incorrect password"
      redirect "/login"
    end
  end

  get "/logout" do
    session.clear
    flash[:info] = "You are logged out!"
    homepage
  end

  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show"
    else
      flash[:error] = "Must be logged in to view a user's recipes"
      homepage
    end
  end

  # If user wants to edit their profile
  get "/users/:slug/edit" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])

      if @user == current_user
        erb :"/users/edit"
      else
        flash[:error] = "Not yours to edit!"
        homepage
      end
    else
      flash[:error] = "Must be logged in!"
      homepage
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
          flash[:success] = "Profile successfully updated!"
          redirect "/users/#{@user.slug}"
        else
          flash[:error] = "Edit failure: #{@user.errors.full_messages.to_sentence}"
          redirect "/users/#{@user.slug}/edit"
        end
      else
        flash[:error] = "Not yours to edit!"
        homepage
      end
    else
      flash[:error] = "Must be logged in!"
      homepage
    end
  end

  # If user wants to delete their profile
  delete "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    if logged_in? && current_user == @user
      @user.destroy
      flash[:success] = "User profile deleted."
      homepage
    else
      flash[:error] = "Not yours to delete!"
      homepage
    end
  end
end

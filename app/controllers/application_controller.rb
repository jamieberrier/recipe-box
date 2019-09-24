require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

    register Sinatra::Flash
  end

  # welcome page
  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :welcome
    end
  end

  helpers do
    def login
      @user = User.find_by(email: params[:user][:email])

      if @user && @user.authenticate(params[:user][:password])
	       session[:user_id] = @user.id
         flash[:message] = "Welcome #{@user.display_name}!"
         redirect "/users/#{@user.slug}"
      elsif !@user
        flash[:alert] = "Incorrect email address"
        redirect "/login"
      else @user && !@user.authenticate(params[:user][:password])
        flash[:alert] = "Incorrect password"
        redirect "/login"
      end
    end

    def current_user
      # if @current_user is assigned, don't evaluate
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      !!current_user
    end

    def authorized_to_edit?(recipe)
      current_user == recipe.user
    end

    def logout!
      session.clear
      flash[:notice] = "You are logged out!"
      redirect "/"
    end

    def delete_recipe!
      @recipe = Recipe.find_by_slug(params[:slug])
      if logged_in? && current_user.id == @recipe.user_id
        @recipe.destroy
        flash[:message] = "Recipe deleted."
        redirect "/users/#{@recipe.user.slug}"
      else
        flash[:error] = "Not yours to delete!"
        redirect "/recipes"
      end
    end
  end # end of helpers
end

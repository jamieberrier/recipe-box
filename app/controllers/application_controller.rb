require './config/environment'

class ApplicationController < Sinatra::Base
  # Sinatra configuration
  configure do
    set :public_folder, 'public'
    set :views, 'app/views' # tell Sinatra where to look for views
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

    register Sinatra::Flash # registering the sinatra flash gem
  end

  # root route - welcome/home page
  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :welcome
    end
  end

  helpers do
    # keeps track of/find the user currently logged in
    def current_user
      # if @current_user is assigned, don't evaluate
      @current_user ||= User.find_by(id: session[:user_id])
    end
    # checks if the user is logged in
    def logged_in?
      !!current_user
    end
     # does the recipe belong to the current user
    def authorized_to_edit?(recipe)
      current_user == recipe.user
    end
    # set flash key/value and redirect to route
    def redirect_to(route, type, message)
      flash[type] = message
      redirect route
    end
  end # end of helpers
end

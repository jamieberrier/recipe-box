require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }

    register Sinatra::Flash
  end

  # welcome/home page
  get "/" do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :welcome
    end
  end

  helpers do
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

    def homepage
      redirect "/"
    end
  end # end of helpers
end

# loads dependencies

require 'sysrandom/securerandom' # generate secure random session secret
ENV['SESSION_SECRET'] = "shotgun will not let me" #SecureRandom.hex(64)
# constant (environment), if exists don't evaluate
ENV['SINATRA_ENV'] ||= "development"
# gem to load gems
require 'bundler/setup'
# require class method(require all gems in gemfile, environment)
Bundler.require(:default, ENV['SINATRA_ENV'])
# establishes the connection to the SQLite database
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite" # path to db file
)
# Do I need this line?
require './app/controllers/application_controller'
# gem to require everything in folder
require_all 'app'

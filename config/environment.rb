require 'sysrandom/securerandom'
ENV['SESSION_SECRET'] = "shotgun will not let me" #SecureRandom.hex(64)

ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
# Do I need this line?
require './app/controllers/application_controller'
require_all 'app'

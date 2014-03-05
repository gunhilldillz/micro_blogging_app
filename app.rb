require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'

configure(:development) {
	set :database, "sqlite3:///mba.sqlite3"
}

set :database, 'sqlite3:///mba.sqlite3'  #add database file
set :sessions, true
set :environment, :developmennt
use Rack::Flash, :sweep => true

# * load Ruby files
# - this command requires all Ruby files (ending in .rb) in the root
#   of the folder AND in a folder called 'models'
# - this lets us split our models up into multiple files == cleaner

Dir['./*.rb','./models/*.rb'].each{ |f| require f }


def current_user
	if session[:user_id]
		@current_user = User.find(  session[:user_id] )
	end
end

get "/" do

	erb :index

end


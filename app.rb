require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'rack-flash'

configure(:development) {
	set :database, "sqlite3:///mba.sqlite3"
}

#set :database, 'sqlite3:///mba.sqlite3'  #add database file # no longer needed, only set above in development environment

set :sessions, true
set :environment, :developmennt

use Rack::Flash, :sweep => true

# * load Ruby files
# - this command requires all Ruby files (ending in .rb) in the root
#   of the folder AND in a folder called 'models'
# - this lets us split our models up into multiple files == cleaner

Dir['./*.rb','./models/*.rb'].each{ |f| require f }

# METHODS

def current_user
	if session[:user_id]
		@current_user = User.find(  session[:user_id] )
	end
end

get "/" do

	erb :index

end




post "/sign-in" do
  @user = User.where(username: params[:username] ).first

  if @user && ( @user.password == params[:password] )
    puts "Yay! Signed in!"
    #store the user id in the session
    session[:user_id] = @user.id

    #notify the user that they are signed in
    flash[:notice] = "You are signed in!"

    redirect to "/signed_in"
  
  else

    flash[:error] = "Unable to sign you in!"
    redirect to "/"
  end
end

get "/signed_in" do
  flash[:notice] = "You are signed in!"
  erb :signed_in
end

post "/create_post" do
  puts params
  if params[:post][:title] && params[:post][:body]
    #make the Post in here...
    @post = Post.create(params[:post])

    if @post
      redirect to("/signed_in")
      else
    redirect to("/signed_in")
  end
end
end
env = ENV['RACK_ENV'] || "development"

require 'data_mapper'
require 'sinatra/base'
require 'sinatra/partial'
require 'rack-flash'

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

Dir.glob(File.join(File.dirname(__FILE__), 'models', '*.rb'), &method(:require))

DataMapper.finalize
DataMapper.auto_upgrade!

require_relative 'helpers/maker'
require_relative 'controllers/peeps'
require_relative 'controllers/makers'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'Dinosaurs and spaceships'
  register Sinatra::Partial
  set :partial_template_engine, :erb
  use Rack::Flash
  use Rack::MethodOverride

  helpers MakerHelpers

  get('/makers/new') { MakersController.call(env) }
  post('/makers')    { MakersController.call(env) }

  get('/')          { PeepsController.call(env) }
  get('/peeps/new') { PeepsController.call(env) }
  post('/peeps')    { PeepsController.call(env) }
  get('/peeps/:id') { PeepsController.call(env) }

  get '/sessions/new' do
    session[:login_location] ||= '/'
    erb :"sessions/new"
  end

  post '/sessions' do
    username, password = params[:username], params[:password]
    maker = Maker.authenticate(username, password)
    if maker
      session[:maker_id] = maker.id
      flash[:notice] = "Welcome, #{maker.name}"
      redirect to(session[:login_location])
    else
      flash[:errors] = ["The email or password are incorrect"]
      redirect to('/sessions/new')
    end
  end

  delete '/sessions' do
    flash[:notice] = "Goodbye!"
    session[:maker_id] = nil
    session[:login_location]
    redirect to('/')
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end

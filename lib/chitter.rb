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
require_relative 'controllers/makers'

class Chitter < Sinatra::Base
  enable :sessions
  set :session_secret, 'Dinosaurs and spaceships'
  register Sinatra::Partial
  set :partial_template_engine, :erb
  use Rack::Flash
  use Rack::MethodOverride

  helpers MakerHelpers

  # get ('/makers/new') { MakersController.call(env) }
  get '/makers/new' do
    erb :"makers/new"
  end

  post '/makers' do
    @maker = Maker.new( name: params[:name],
                        username: params[:username],
                        email: params[:email],
                        password: params[:password],
                        password_confirmation: params[:confirmation] )
    if @maker.save
      session[:maker_id] = @maker.id
      flash[:notice] = "Welcome, #{@maker.name}"
      redirect to('/')
    else
      flash[:errors] = @maker.errors.full_messages
      redirect to('/makers/new')
    end
  end

  get '/' do
    @peeps = Peep.all(order: [ :time.desc ])
    erb :index
  end

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

  get '/peeps/new' do
    if session[:maker_id]
      erb :"peeps/new"
    else
      flash[:errors] = ["Please sign in to post a peep"]
      session[:login_location] = '/peeps/new'
      redirect to('/sessions/new')
    end
  end

  post '/peeps' do
    message = params[:message]
    maker = current_user
    Peep.create(message: message, maker: maker, time: Time.now)
    flash[:notice] = "Your peep has been posted!"
    redirect to('/')
  end

  get '/peeps/:id' do |id|
    @peep = Peep.first(id: id)
    erb :"peeps/peep"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

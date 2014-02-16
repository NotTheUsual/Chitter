require 'sinatra/partial'
require 'rack-flash'

require_relative '../helpers/maker'

class Base < Sinatra::Base
	enable :sessions
  set :session_secret, 'Dinosaurs and spaceships'
	register Sinatra::Partial
  set :partial_template_engine, :erb
  use Rack::MethodOverride
  use Rack::Flash

	set :views, File.join(File.dirname(__FILE__), '../views')

	helpers MakerHelpers
end
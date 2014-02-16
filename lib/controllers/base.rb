require 'sinatra/partial'

require_relative '../helpers/maker'

class Base < Sinatra::Base
	register Sinatra::Partial
  set :partial_template_engine, :erb
  use Rack::MethodOverride

	set :views, File.join(File.dirname(__FILE__), '../views')

	helpers MakerHelpers
end
env = ENV['RACK_ENV'] || "development"

require 'data_mapper'
require 'sinatra/base'

require_relative 'db_config'

Dir.glob(File.join(File.dirname(__FILE__), 'controllers', '*.rb'), &method(:require))

class Chitter < Sinatra::Base
  set :public_folder, File.join(File.dirname(__FILE__), '../public')

  get('/makers/new')   { MakersController.call(env) }
  post('/makers')      { MakersController.call(env) }

  get('/')             { PeepsController.call(env)  }
  get('/peeps/new')    { PeepsController.call(env)  }
  post('/peeps')       { PeepsController.call(env)  }
  get('/peeps/:id')    { PeepsController.call(env)  }

  get('/sessions/new') { LoginController.call(env)  }
  post('/sessions')    { LoginController.call(env)  }
  delete('/sessions')  { LoginController.call(env)  }

  # start the server if ruby file executed directly
  run! if app_file == $0
end

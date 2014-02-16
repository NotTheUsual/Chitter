require 'sinatra/partial'

require_relative '../helpers/maker'

class PeepsController < Sinatra::Base
	register Sinatra::Partial
  set :partial_template_engine, :erb

	set :views, File.join(File.dirname(__FILE__), '../views')

	helpers MakerHelpers

	get '/' do
    @peeps = Peep.all(order: [ :time.desc ])
    erb :index
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
end
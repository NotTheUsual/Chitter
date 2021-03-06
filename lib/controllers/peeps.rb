require_relative 'base'

class PeepsController < Base
	get '/' do
    session[:login_location] = '/' unless session[:maker_id]
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
    if params[:original_id]
      original = Peep.first(id: params[:original_id])
      reply = Peep.create(message: message, maker: maker, time: Time.now)
      original.replies << reply
      original.save
      flash[:notice] = "Your reply has been posted!"
      redirect to("/peeps/#{params[:original_id]}")
    else
      Peep.create(message: message, maker: maker, time: Time.now)
      flash[:notice] = "Your peep has been posted!"
      redirect to('/')
    end
  end

  get '/peeps/:id' do |id|
    @peep = Peep.first(id: id)
    erb :"peeps/peep"
  end
end
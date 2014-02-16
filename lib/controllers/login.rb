require_relative 'base'

class LoginController < Base
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
end
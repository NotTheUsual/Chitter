require_relative 'base'

class MakersController < Base
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
end
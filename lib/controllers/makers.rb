require 'sinatra/partial'

require_relative '../helpers/maker'

class MakersController < Sinatra::Base
	register Sinatra::Partial
  set :partial_template_engine, :erb

	set :views, File.join(File.dirname(__FILE__), '../views')

	helpers MakerHelpers

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
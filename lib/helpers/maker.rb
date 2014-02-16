module MakerHelpers
  def current_user    
    @current_user ||=Maker.get(session[:maker_id]) if session[:maker_id]
  end
end
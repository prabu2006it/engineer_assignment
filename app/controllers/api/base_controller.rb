class Api::BaseController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  
  def current_token
  	@access_token = Doorkeeper::AccessToken.find_by(token: params[:access_token])
  	return @access_token
  end

  def current_user
  	User.find(current_token.resource_owner_id) unless current_token.nil?
  end
end
class Api::V1::ApiController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    render :json => {:user => current_user}
  end

end

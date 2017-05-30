class TokensController < ApplicationController

  before_action :authenticate_user!

  def index
    @token = current_user.authentication_token
  end

  def regenerate
    current_user.regenerate_token
    current_user.save!
    current_user.messages.add_token_regeneration_message(user: current_user)
    redirect_to({action: 'index'}, notice: "Successfully regenerated your token")
  end

end

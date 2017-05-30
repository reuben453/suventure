class MessagesController < ApplicationController

  before_action :authenticate_user!

  def index
    @messages = current_user.messages || []
  end

end

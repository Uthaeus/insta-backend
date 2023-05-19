class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user_current]
  respond_to :json 

  def home
    render json: { message: 'Hello World' }
  end

  def user_current
    render json: current_user
  end
end

class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user_current]
  respond_to :json 

  def home
  end

  def user_current
    render json: current_user
  end
end

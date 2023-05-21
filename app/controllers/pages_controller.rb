class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:user_current]
  respond_to :json 

  def home
    @posts = Post.all.order(created_at: :desc).limit(6)
    render json: @posts.as_json(include: [:user, :comments => {include: :user}])
  end

  def user_current
    render json: current_user, include: [:posts, :comments]
  end
end

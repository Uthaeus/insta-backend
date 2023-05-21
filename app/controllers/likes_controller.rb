class LikesController < ApplicationController
  before_action :set_like, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]
  before_action :comment_or_post, only: %i[ create update destroy ]
  respond_to :json

  # GET /likes
  def index
    @likes = Like.all

    render json: @likes
  end

  # GET /likes/1
  def show
    render json: @like
  end

  # POST /likes
  def create
    if @comment_like
      like_resource(comment)
    else
      like_resource(post)
    end

    if @like.save
      render json: @like, status: :created, location: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /likes/1
  def update
    if @like.update(like_params)
      render json: @like
    else
      render json: @like.errors, status: :unprocessable_entity
    end
  end

  # DELETE /likes/1
  def destroy
    if @comment_like
      comment.likes.where(user: current_user).destroy_all
    else
      post.likes.where(user: current_user).destroy_all
    end
    flash[:success] = "Unliked! :("
  end

  private

  def like_resource(obj)
    if obj.likes.where(user: current_user.id).present?
      flash[:error] = "You've already upvoted this! + #{like_params} + #{@comment_like} + #{obj}"
    if @comment_like
      if obj.likes.create(user: current_user, post: @post)
        flash[:success] = "Upvoted Comment! + #{like_params} + #{@comment_like} + #{obj}"
      else
          flash[:error] = "An error prevented you from upvoting."
      end
    elsif obj.likes.create(user: current_user)
      flash[:success] = "Upvoted Post! + #{like_params} + #{@comment_like} + #{obj}"
    else
      flash[:error] = "An error prevented you from upvoting."
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def like_params
      params.permit(:liked,:post_id, :comment_id).merge(user_id: current_user.id)
    end

    def comment_or_post
      if comment 
        @comment_like = true 
      else
        @comment_like = false
      end
    end

    def post 
      @post = Post.find(params[:post_id])
    end

    def comment
      unless params[:comment_id].nil?
        @comment = post.comments.find(params[:comment_id])
      end
    end
end

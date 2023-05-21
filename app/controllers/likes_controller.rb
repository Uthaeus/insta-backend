class LikesController < ApplicationController
  # before_action :authenticate_user!, only: %i[ create update destroy ]
  before_action :set_like, only: %i[ show update destroy ]
  before_action :comment_or_post, only: %i[ create update destroy ]
  respond_to :json

  # q: how can i resolve theses errors? NoMethodError (undefined method `id' for nil:NilClass):
  
  # app/controllers/likes_controller.rb:121:in `like_resource'
  # app/controllers/likes_controller.rb:25:in `create'?
  # a: the like_params method is not returning the correct params (see below)
  # q: what are the correct params the like_params method should return?
  # a: the like_params method should return the params for the like resource


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
    p "like_params: #{like_params}"
    if @comment_like
      like_resource(comment)
    else
      like_resource(post)
    end

    # if @like.save
    #   render json: @like, status: :created, location: @like
    # else
    #   render json: @like.errors, status: :unprocessable_entity
    # end
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
  # q: why is the code below causing NoMethodError (undefined method `id' for nil:NilClass)?
  # a: because the like_params method is not returning the correct params
  # def set_like
  #   if @comment_like
  #     @like = comment
  #   else
  #     @like = post
  #   end
  # end

  def comment_or_post
    if params[:comment_id]
      @comment_like = true
    else
      @comment_like = false
    end
  end

  # def set_like
  #   if @comment_like
  #     @like = comment.likes.find(params[:id])
  #   else
  #     @like = post.likes.find(params[:id])
  #   end
  # end

  # def comment
  #   @comment ||= Comment.find(params[:comment_id])
  # end

  # def post
  #   @post ||= Post.find(params[:post_id])
  # end

  # # Only allow a list of trusted parameters through.
  # def like_params
  #   params.require(:like).permit(:user_id, :post_id, :comment_id)
  # end

  ##################
  # q: why is the code below causing NoMethodError (undefined method `id' for nil:NilClass)?
  # a: because the like_params method is not returning the correct params
  def set_like
    if params[:comment_id]
      @comment_like = true
      # @like = comment
    else
      @comment_like = false
      # @like = post
    end
  end

  def comment
    Comment.find(params[:comment_id])
  end

  def post
    # q: why is the code below causing NoMethodError (undefined method `id' for nil:NilClass)?
    # a: because the like_params method is not returning the correct params
    # Post.find(params[:post_id])
    Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:user_id, :post_id, :comment_id)
  end

  def like_resource(obj)
    if obj.likes.where(user: current_user.id).present?
      flash[:error] = "You already liked this!"
    elsif obj.likes.create(user: current_user)
      flash[:success] = "Upvoted! + #{like_params} + #{@comment_like} + #{obj}"
    else
      flash[:error] = "An error prevented you from upvoting."
    end
  end
end
  ##################        ########################
  # def like_resource(obj)
  #   if obj.likes.where(user: current_user.id).present?
  #     #flash[:error] = 
  #     p "You already liked this!"

  #   elsif @comment_like
  #     if obj.likes.create(user: current_user, post: @post)
  #       #flash[:success] = "Upvoted Comment! + #{like_params} + #{@comment_like} + #{obj}"
  #       p "Upvoted Comment! + #{like_params} + #{@comment_like} + #{obj}"
  #     else
  #         #flash[:error] = "An error prevented you from upvoting."
  #         p "An error prevented you from upvoting."
  #     end
  #   elsif obj.likes.create(user: current_user)
  #     # flash[:success] = "Upvoted Post! + #{like_params} + #{@comment_like} + #{obj}"
  #     p "Upvoted Post! + #{like_params} + #{@comment_like} + #{obj}"
  #   else
  #     #flash[:error] = "An error prevented you from upvoting."
  #     p "An error prevented you from upvoting."
  #   end
  # end

    # Use callbacks to share common setup or constraints between actions.
    # def set_like
    #   @like = Like.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    # def like_params
      
    #   params.require(:like).permit(:liked, :post_id, :comment_id, :user_id)
      
    #   # params.permit(:liked,:post_id, :comment_id).merge(user_id: current_user.id)
    # end

    # def comment_or_post
    #   if params[:post_id].nil? 
    #     @comment_like = true
    #   else
    #     @comment_like = false
    #   end
    # end

    # def post 
    #   p 'hitting post'
    #   @post = Post.find(params[:post_id])
    # end

    # def comment
    #   unless params[:comment_id].nil?
    #     @comment = post.comments.find(params[:comment_id])
    #   end
    # end
#end

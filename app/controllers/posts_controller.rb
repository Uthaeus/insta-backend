class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]
  respond_to :json

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts.as_json(include: [:user, :comments, :likes, :topics, :comments => {include: [:user, :likes]}])
  end

  # GET /posts/1
  def show
    # @is_liked = Like.where(user_id: current_user.id, post_id: @post.id).exists?
    # render json: @post.as_json(include: [:user, :comments, :likes, :topics, :comments => {include: [:user, :likes]}], methods: [:is_liked])
    render json: @post.as_json(include: [:user, :comments, :likes, :topics, :comments => {include: [:user, :likes]}])
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:image, :content, :user_id, :topic_id)
    end
end

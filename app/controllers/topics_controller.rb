class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  respond_to :json

  # GET /topics
  def index
    @topics = Topic.all

    render json: @topics
  end

  # GET /topics/1
  def show
    
    @posts = topic_scope(@topic.title)
    render json: { topic: @topic.as_json(include: [:user => {include: [:comments, :posts]}]), posts: @posts.as_json(include: [:user, :comments => {include: :user}]) }
      
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      render json: @topic, status: :created, location: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /topics/1
  def update
    if @topic.update(topic_params)
      render json: @topic
    else
      render json: @topic.errors, status: :unprocessable_entity
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topic_params
      params.require(:topic).permit(:title, :post_id, :user_id, :comment_id)
    end
end

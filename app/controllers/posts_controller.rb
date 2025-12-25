class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :authorize_post!, only: [:edit, :update, :destroy]

  def authorize_post!
    redirect_to posts_path, alert: "Access denied" unless @post.user == current_user
  end
  def index
      if params[:q].present?
        @posts = Post
                   .where("title LIKE ?", "%#{params[:q]}%")
                   .order(created_at: :desc)
      else
        @posts = Post.order(created_at: :desc)
      end
    end

    def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id 
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    head :forbidden unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    head :forbidden unless @post.user == current_user

    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    head :forbidden unless post.user == current_user

    post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

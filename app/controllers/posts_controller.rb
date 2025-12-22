class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]

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
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end
end

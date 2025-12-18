class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:edit_comment_id].present?
      update_comment
    else
      create_comment
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end

  private

    def create_comment
      @post = Post.find(params[:post_id])
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user
      @comment.save
      redirect_back fallback_location: root_path
    end

    def update_comment
      comment = Comment.find(params[:edit_comment_id])
      return head :forbidden unless comment.authored_by?(current_user)
      if comment.update!(content: comment_params[:content])
        redirect_back fallback_location: root_path
      else
        render :edit
      end
    end

    def comment_params
      params.require(:comment).permit(:content, :parent_id)
    end
end

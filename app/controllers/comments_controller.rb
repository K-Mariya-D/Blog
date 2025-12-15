class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Comment.create(
      content: params[:content],
      user_id: params[:user_id],
      post_id: params[:post_id]
    )

    redirect_back fallback_location: root_path
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back fallback_location: root_path
  end
end

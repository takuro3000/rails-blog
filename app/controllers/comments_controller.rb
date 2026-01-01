class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: %i[ destroy ]
  before_action :authorize_user!, only: %i[ destroy ]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post, notice: "Comment was successfully created."
    else
      redirect_to @post, alert: "Comment could not be created."
    end
  end

  def destroy
    @comment.destroy!
    redirect_to @post, notice: "Comment was successfully deleted.", status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user!
    unless @comment.user == current_user
      redirect_to @post, alert: "You are not authorized to perform this action."
    end
  end
end


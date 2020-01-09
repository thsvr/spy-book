class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if @comment.save
      flash[:success] = 'Comment posted!'
      redirect_to users_path
    else
      flash.now[:danger] = 'Failed to post comment'
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:content)
  end
end

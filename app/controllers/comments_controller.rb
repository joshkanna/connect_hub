class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      # If there are validation errors, set flash message and redirect back
      flash[:error] = 'Failed to create comment. Please fix the errors.' + @comment.errors.full_messages.join(', ')
      redirect_to user_post_path(@user, @post)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy
    redirect_to user_post_path(@user, @post)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
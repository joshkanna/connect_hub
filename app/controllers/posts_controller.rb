class PostsController < ApplicationController 
  before_action :set_post, only: [:show]
  
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

  def show
    @user = User.find(params[:user_id])
    if @post.nil?
      redirect_to (user_posts_path), notice: "This post has been deleted."
    end
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new

    require_post_owner
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.new(post_params)


    if @post.save
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = "Please try again."
      render :new, status: :unprocessable_entity
    end
  end 

  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

  end

  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])



    if @post.update(post_params)
      redirect_to user_post_path(@user, @post)
    else
      flash.now[:error] = "Please try again."
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])


    @post.destroy

    redirect_to user_posts_path, status: :see_other
  end


  private 


  def post_params
    params.require(:post).permit(:title, :body)
  end
end

def require_post_owner
  if Current.user != @user
    redirect_to user_posts_path(@user)
  end
end

def set_post
  @post = Post.find_by(id: params[:id])
end
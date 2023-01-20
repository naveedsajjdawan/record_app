class PostsController < ApplicationController
   before_action :authenticate_user!
  
  def index
    @posts = current_user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user 
     if @post.save
       redirect_to @post 
     else
       render 'new'
     end
  end

  def edit
     @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "update done successfully."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
     redirect_to reports_path
  end

  private
    def post_params
      params.require(:post).permit(:text)
    end
end
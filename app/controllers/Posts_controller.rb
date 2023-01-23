class PostsController < ApplicationController
   before_action :authenticate_user!
   
   before_action :find_post_id, only: [:show, :edit, :update, :destroy]
  
  def index
    @posts = current_user.posts
  end

  def show
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
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "update done successfully."
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
     redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:text)
    end

    def find_post_id
      @post = Post.find(params[:id])
    end
end
class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to songs_path
  end

  def search
    if params[:keyword].present?
      @posts = Post.where('listen LIKE ? or text LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end

  private

  def post_params
    params.require(:post).permit(:song_id, :listen, :text)
  end
end

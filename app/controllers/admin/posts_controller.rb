class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_song_path(post.song.id)
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

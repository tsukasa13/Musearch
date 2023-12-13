class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @song = Song.find(params[:song_id]) # 関連するSongオブジェクトを取得
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.song_id = @song.id# 関連を設定
    if @post.save
      redirect_to song_path(@post.song.id)
    else
      # 保存に失敗した場合の処理
      render :new
    end
  end

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
    redirect_to song_post_path(@post.id)
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

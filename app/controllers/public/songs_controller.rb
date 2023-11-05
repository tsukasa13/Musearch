class Public::SongsController < ApplicationController
  before_action :authenticate_user!

  def new
    @song = Song.new
    @song.posts.new
  end

  def create
    @song = Song.new(song_params)
    @song.user_id = current_user.id
    if @song.save
      redirect_to song_path(@song.id)
    else
      render :new
    end
  end

  def index
    @songs = Song.page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @posts = Post.page(params[:page])
  end

  private

  def song_params
    params.require(:song).permit(:user_id, :song_name, :artist_name, :genre, posts_attributes:[:id, :song_id, :listen, :text])
  end
end

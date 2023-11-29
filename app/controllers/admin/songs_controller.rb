class Admin::SongsController < ApplicationController
  def index
    @songs = Song.page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @posts = Post.where(song_id: @song.id).page(params[:page])
  end

  def search
    if params[:keyword].present?
      @songs = Song.where('song_name LIKE ? or artist_name LIKE ? or genre LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @songs = Song.all
    end
  end

  def genre
    if params[:genre].present?
      genres = params[:genre].split(",") # パラメータのジャンルを配列に分割する
      @songs = Song.where(genre: genres) # ジャンルが配列に含まれる曲を取得する
      @genre = params[:genre]
    else
      @songs = Song.all
      @genre = nil # ジャンルが指定されていない場合は、@genre変数にはnilを設定しておく
    end
  end

  private

  def song_params
    params.require(:song).permit(:user_id, :song_name, :artist_name, :genre, posts_attributes:[:id, :song_id, :listen, :text])
  end
end

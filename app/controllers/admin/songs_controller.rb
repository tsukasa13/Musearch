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
      @songs = Song.all.where('genre LIKE(?)', "%#{"J-POP"}%").where('genre LIKE(?)', "%#{"ロック"}%").where('genre LIKE(?)', "%#{"K-POP"}%").where('genre LIKE(?)', "%#{"演歌"}%").where('genre LIKE(?)', "%#{"クラシック"}%").where('genre LIKE(?)', "%#{"洋楽"}%").where('genre LIKE(?)', "%#{"アニメ"}%")
      @genre = params[:genre]
    else
      @songs = Song.all
    end
  end

  private

  def song_params
    params.require(:song).permit(:user_id, :song_name, :artist_name, :genre, posts_attributes:[:id, :song_id, :listen, :text])
  end
end

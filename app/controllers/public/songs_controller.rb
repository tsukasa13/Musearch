class Public::SongsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:likes]

  def new
    @song = Song.new
    @song.posts.new
  end

  def create
    @song = Song.find_by(song_name: params[:song][:song_name])
    if @song != nil
      if @song.in_song?
        redirect_to song_path(@song) # リダイレクト先を指定する
      else
        @post = Post.new(song_params[:posts_attributes][:"0"])
        @post.song_id = @song.id
        if @post.save
          redirect_to song_path(@post.song.id) # 保存が成功した場合のリダイレクト先を指定する
        else
          render "new" # 保存が失敗した場合はnewアクションのビューを表示する
        end
      end
    else
      @song = Song.new(song_params)
      if @song.save
        redirect_to song_path(@song) # 保存が成功した場合のリダイレクト先を指定する
      else
        render "new" # 保存が失敗した場合はnewアクションのビューを表示する
      end
    end
  end

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

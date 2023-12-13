class Public::SongsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:likes]

  def new
    @song = Song.new
    if params[:name].present?
      @songs = Song.where('song_name like ?', "%#{params[:name]}%")
    else
      @songs = []
    end
  end

  def create
    @song = current_user.songs.build(song_params)
    if @song.save
      flash[:notice] = "saved"
      redirect_to song_path(@song)
    else
      flash.now[:alert] = 'failed'

      # 検索結果の取得と代入
      @songs = Song.all

      render :new
    end
  end

  # def create
  #   @song = Song.find_by(song_name: params[:song][:song_name])
  #   if @song.nil?
  #     @song = Song.new(song_params)
  #     @song.user_id = current_user.id
  #     if @song.save
  #       redirect_to song_path(@song) # 保存が成功した場合のリダイレクト先を指定する
  #     else
  #       flash[:error] = @song.errors.full_messages.join("<br>").html_safe
  #       render "new" # 保存が失敗した場合はnewアクションのビューを表示する
  #     end
  #   elsif @song.in_song?
  #     redirect_to song_path(@song) # リダイレクト先を指定する
  #   else
  #     @post = Post.new(song_params[:posts_attributes][:"0"])
  #     @post.song_id = @song.id
  #     if @post.save
  #       redirect_to song_path(@post.song.id) # 保存が成功した場合のリダイレクト先を指定する
  #     else
  #       flash[:error] = @post.errors.full_messages.join("<br>").html_safe
  #       render "new" # 保存が失敗した場合はnewアクションのビューを表示する
  #     end
  #   end
  # end

  def index
    @songs = Song.page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @posts = Post.where(song_id: @song.id).page(params[:page])
    @post = Post.new
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
    params.require(:song).permit(:song_name, :artist_name, :genre)#, posts_attributes:[:id, :song_id, :listen, :text])
  end
end

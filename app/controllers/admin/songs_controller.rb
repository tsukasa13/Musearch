class Admin::SongsController < ApplicationController
  def index
    @songs = Song.page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
    @posts = Post.page(params[:page])
  end
end

class Public::SongsController < ApplicationController
  def create
  end

  def index
    @songs = Song.page(params[:page])
  end

  def show
    @song = Song.find(params[:id])
  end
end

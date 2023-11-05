class Admin::SongsController < ApplicationController
  def index
    @songs = Song.page(params[:page])
  end

  def show
  end
end

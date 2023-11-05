class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

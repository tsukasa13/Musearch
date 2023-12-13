class Public::LikesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    like.save
    redirect_to song_post_path(post.song.id, post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to song_post_path(post.song.id, post.id)
  end
end

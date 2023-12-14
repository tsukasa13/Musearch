class Public::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to song_post_path(post.song.id, post.id)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to song_post_path(comment.post.song, comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

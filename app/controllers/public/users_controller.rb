class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @likes = Post.likes(current_user, params[:page], 12)
    @songs = current_user.songs.includes(:posts)
    #@posts = Post.where(song_id: @songs.map(&:id))
    @posts = current_user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_mypage_path
  end

  def confirm_withdraw
    @user = current_user
  end

  def withdraw
     @user = current_user
     @user.update(is_deleted: true)
     reset_session
     flash[:notice] = "退会処理を実行いたしました"
     redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end

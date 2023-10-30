class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
  end

  def confirm_withdraw
  end

  def withdraw
  end
end

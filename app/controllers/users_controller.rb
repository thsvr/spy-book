class UsersController < ApplicationController
  def index
    @users = User.all
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
  end
end

# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
    # @friends = current_user.friends
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy; end

  private

  def posts_params
    params.require(:post).permit(:content)
  end
end

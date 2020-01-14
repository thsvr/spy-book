# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.all
    @friends = Friendship.friends
    @my_friends = Friendship.friends.where('sent_by_id =?', current_user.id).or(Friendship.friends.where('sent_to_id =?', current_user.id))
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

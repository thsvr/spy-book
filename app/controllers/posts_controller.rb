# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @post = Post.all
    
    my_friends = Friendship.friends.where('sent_by_id =?', current_user.id).or(Friendship.friends.where('sent_to_id =?', current_user.id))
    friends = []
    my_friends.each do |f|      
      friends << f.sent_to_id if f.sent_to_id != current_user.id      
      friends << f.sent_by_id if f.sent_by_id != current_user.id 
    end   

    @friends = []
    @friends << User.find(current_user.id)
    friends.each do |i|
      @friends << User.find(i)
    end
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

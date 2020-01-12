class FriendshipsController < ApplicationController
  # Creates friend request
  def create
    @friendrequest = current_user.friendsent.build(sent_to_id: params[:user_id])
    if @friendrequest.save
      flash[:sucess] = "Friend Request sent!"
    else
      flash[:danger] = "Friend Request could not be sent!"
    end
    redirect_back(fallback_location: root_path)
  end

  def acceptFriend
    @friendrequest = Friendship.find(params[:id])
    if @friendrequest.sent_to_id == current_user.id
      @friendrequest.status = true
      flash[:sucess] = "Friend Request Accepted!"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @friendrequest = Friendship.find(params[:id])

    @friendrequest.destroy
    flash[:success] = 'Removed friend'
    redirect_back(fallback_location: root_path)
  end
end

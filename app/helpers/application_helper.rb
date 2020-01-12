# frozen_string_literal: true

module ApplicationHelper
  # Checks whether or not a comment or post has a like record relating to the current user
  # returning either true of false
  def liked?(subject, type)
    result = false
    result = Like.where(user_id: current_user.id, post_id: subject.id).exists? if type == 'post'
    result = Like.where(user_id: current_user.id, comment_id: subject.id).exists? if type == 'comment'

    result
  end

  # Checks whether or not a user has had a friend request sent to them by the current user
  # returning either true or false
  def friendRequestSent?(user)
    requestSent = current_user.friendsent.exists?(sent_to_id: user.id, status: false)
  end

  # Checks whether or not a user has sent a friend request to the current user
  # returning either true or false
  def friendRequestRecieved?(user)
    current_user.friendrequests.exists?(sent_by_id: user.id, status: false)
  end

  # Checks whether or not a user has had a friend request sent to them by the current user
  # or if the current user has been sent a friend request by the user 
  # and the reciever has accepted the friendship
  # returning either true or false
  def friendRequestStatus?(user)
    requestSent = current_user.friendsent.exists?(sent_to_id: user.id, status: true)
    requestRecieved = current_user.friendrequests.exists?(sent_by_id: user.id, status: true)

    return true if requestSent != requestRecieved 
    return true if requestSent == requestRecieved && requestSent == true
    return false if requestSent == requestRecieved && requestSent == false
  end
end

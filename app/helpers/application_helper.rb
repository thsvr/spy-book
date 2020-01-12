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
    current_user.friendsent.exists?(sent_to_id: user.id)
  end
end

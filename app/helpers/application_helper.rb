# frozen_string_literal: true

module ApplicationHelper
  def liked?(subject, type)
    result = false
    result = Like.where(user_id: current_user.id, post_id: subject.id).exists? if type == 'post'
    result = Like.where(user_id: current_user.id, comment_id: subject.id).exists? if type == 'comment'

    result
  end
end

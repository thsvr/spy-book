class Notification < ApplicationRecord
  belongs_to :user
  scope :friend_requests, -> { where('type = friendRquest') }
  scope :likes, -> { where('type = like') }
  scope :comments, -> { where('type = comment') }

end

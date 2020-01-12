class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: "sent_to_id"
  belongs_to :user, foreign_key: "sent_by_id"
  scope :friends, -> { where("status =?", true) }
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, dependent: :destroy
  validates :content, length: { in: 1..100 }, allow_blank: false
end

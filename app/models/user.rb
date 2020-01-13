# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_sent, :class_name => 'Friendship', foreign_key:"sent_by_id"
  has_many :friend_request, :class_name => 'Friendship', foreign_key:"sent_to_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :fname, length: { in: 3..15 }, presence: true
  validates :lname, length: { in: 3..15 }, presence: true
end

class User < ApplicationRecord
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friend_sent, class_name: 'Friendship', foreign_key: 'sent_by_id', inverse_of: 'sent_by', dependent: :destroy
  has_many :friend_request, class_name: 'Friendship', foreign_key: 'sent_to_id',
                            inverse_of: 'sent_to', dependent: :destroy
  has_many :notifications, dependent: :destroy
  mount_uploader :image, PictureUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  validates :fname, length: { in: 3..15 }, presence: true
  validates :lname, length: { in: 3..15 }, presence: true
  validate :picture_size

  # Searches Friendship database and returns array, 'friends',
  # which contains records of all mutual friendships for current_user
  def friends
    my_friends = Friendship.friends.where('sent_by_id =?', id)
    friend_ids = []
    my_friends.each do |f|
      friend_ids << f.sent_to_id if f.sent_to_id != id
      friend_ids << f.sent_by_id if f.sent_by_id != id
    end

    # Adds the User record from each friend id retrieved into friends array
    friends = []
    friend_ids.each do |i|
      friends << User.find(i)
    end

    friends
  end

  # Returns all posts from this user's friends and self
  def friends_and_own_posts
    friends = friends()
    friends << User.find(id)
    our_posts = []
    friends.each do |f|
      f.posts.each do |p|
        our_posts << p
      end
    end

    our_posts
  end

  # Returns all users that current user has sent a friend request to but hasn't accepted or declined
  def pending_requests
    friends_requested = []
    friend_sent.each do |r|
      friends_requested << r.sent_to if r.status == false
    end

    friends_requested
  end

  # Returns all users that current user has recieved a friend request from but hasn't accepted or declined
  def recieved_requests
    friend_requests = []
    friend_request.each do |r|
      friend_requests << r.sent_by if r.status == false
    end

    friend_requests
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.fname = auth.info.first_name # assuming the user model has a first name
      user.lname = auth.info.last_name # assuming the user model has a last name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add(:image, 'should be less than 1MB') if image.size > 1.megabytes
  end
end

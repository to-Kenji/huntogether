class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 15 }
  validates :profile, length: { maximum: 80 }
  has_many :techniques, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorites, through: :bookmarks, source: :technique
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

 
  mount_uploader :image, ImageUploader

  include Paginate
  
  def already_liked?(technique)
    self.likes.exists?(technique_id: technique.id)
  end

  def favorite(technique)
    self.bookmarks.find_or_create_by(technique_id: technique.id)
  end
  
  def unfavorite(technique)
    bookmark = self.bookmarks.find_by(technique_id: technique.id)
    bookmark.destroy if bookmark
  end

  def already_favorited?(technique)
    self.favorites.include?(technique)
  end
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def following_techniques
    Technique.where(user_id: self.following_ids)
  end
end

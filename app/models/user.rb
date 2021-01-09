class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :profile, length: { maximum: 200 }
  has_many :techniques
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks
  has_many :favorites, through: :bookmarks, source: :technique

  mount_uploader :image, ImageUploader

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
    self.bookmarks.exists?(technique_id: technique.id)
  end
  
  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

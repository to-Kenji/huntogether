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

  mount_uploader :image, ImageUploader

  
  def do_like(other_technique)
    self.likes.find_or_create_by(technique_id: other_technique.id)
  end

  def do_unlike(other_technique)
    relationship = self.likes.find_by(technique_id: other_technique.id)
    relationship.destroy if relationship
  end

  def already_liked?(technique)
    self.likes.exists?(technique_id: technique.id)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'ゲストユーザー') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end

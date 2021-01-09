class Technique < ApplicationRecord
  belongs_to :user
  belongs_to :weapon
  belongs_to :monster
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks
  has_many :favors, through: :bookmarks, source: :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 255 }
  validates :difficulty, presence: true
  
  scope :recent, -> { order(created_at: :desc) }


end

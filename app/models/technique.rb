class Technique < ApplicationRecord
  belongs_to :user
  belongs_to :weapon
  belongs_to :monster

  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 255 }
  
end

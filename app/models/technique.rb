class Technique < ApplicationRecord
  belongs_to :user
  belongs_to :weapon
  belongs_to :monster
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favors, through: :bookmarks, source: :user

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true
  before_save :slugify
  scope :recent, -> { order(created_at: :desc) }

  def self.create_technique_ranks
    top_bookmarks = Bookmark.group(:technique_id).order('count(technique_id) desc').limit(5).pluck(:technique_id)
    Technique.find(top_bookmarks)
  end

  def slugify
    self.youtube_url = youtube_url.last(11)
  end
end

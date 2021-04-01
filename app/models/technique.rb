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
  VALID_URL_REGEX = %r{\A(https://[\w.]+/)?[\w+=?\-]+\z}.freeze
  validates :youtube_url, allow_blank: true, length: { maximum: 43 }, format: { with: VALID_URL_REGEX }

  before_save :slugify

  include Recent
  include Paginate

  def self.create_technique_ranks
    top_bookmarks = Bookmark.group(:technique_id).order('count(technique_id) desc').limit(5).pluck(:technique_id)
    Technique.find(top_bookmarks)
  end

  def slugify
    self.youtube_url = youtube_url.last(11)
  end
end

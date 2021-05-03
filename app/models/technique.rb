class Technique < ApplicationRecord
  belongs_to :user
  belongs_to :weapon
  belongs_to :monster
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favors, through: :bookmarks, source: :user
  has_many :tagmaps, dependent: :destroy
  has_many :tags, through: :tagmaps

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

  def save_tags(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_tag|
      unneed_tag = Tag.find_by(tag_name: old_tag)
      self.tags.delete(unneed_tag)
    end

    new_tags.each do |new_tag|
      added_tag = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << added_tag
    end
  end
end

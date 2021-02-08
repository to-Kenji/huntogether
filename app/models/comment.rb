class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :technique
  validates :content, presence: true

  include Recent
end

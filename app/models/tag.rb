class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
  has_many :techniques, through: :tagmaps
end

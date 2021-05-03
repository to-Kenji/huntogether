class Tagmap < ApplicationRecord
  belongs_to :technique
  belongs_to :tag
end

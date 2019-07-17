class Image < ApplicationRecord
  belongs_to :tour
  validates :image, presence: true
  validates :tour_id, presence: true
end

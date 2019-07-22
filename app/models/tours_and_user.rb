class ToursAndUser < ApplicationRecord
  belongs_to :tour
  belongs_to :user

  validates :user_id, presence: true
  validates :tour_id, presence: true
end

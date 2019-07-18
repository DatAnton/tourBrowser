class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  validates :body, presence: true
end

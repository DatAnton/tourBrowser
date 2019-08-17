class Plan < ApplicationRecord
  belongs_to :user
  has_many :plan_points

  validates :name, presence: true
  validates :user_id, presence: true
end

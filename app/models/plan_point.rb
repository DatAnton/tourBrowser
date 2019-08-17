class PlanPoint < ApplicationRecord
  belongs_to :plan
  belongs_to :tour

  validates :plan_id, presence: true
  validates :tour_id, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true
  validates :day_date, presence: true

  validate :from_must_be_before_to_time

  private

  def from_must_be_before_to_time
    errors.add(:from_time, ' must be earlier than To time') unless
       from_time < to_time
  end

end

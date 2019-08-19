class Hotel < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :image_hotels

  validates :name, presence: true
  validates :description, presence: true
  validates :contacts, presence: true
  validates :address, presence: true
  validates :location_id, presence: true
  validates :free, presence: true

  scope :main_image, -> (image_id){ ImageHotel.find(image_id) }
end

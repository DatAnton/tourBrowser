class Location < ApplicationRecord
  has_many :tours, dependent: :destroy
  has_many :hotels, dependent: :destroy
end

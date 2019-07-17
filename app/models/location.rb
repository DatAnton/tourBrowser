class Location < ApplicationRecord
  has_many :tours, dependent: :destroy
end

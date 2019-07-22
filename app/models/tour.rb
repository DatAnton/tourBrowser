class Tour < ApplicationRecord
  belongs_to :location

  has_many :images, dependent: :destroy
  has_one :image, dependent: :destroy

  scope :creator, ->(user_id) { User.find(user_id) }

  has_many :tours_and_user
  has_many :users, through: :tours_and_user
  has_many :comments, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :location_id, presence: true

  def self.get_regions
    regions = [
      'Автономная Республика Крым',
      'Винницкая область',
      'Волынская область',
      'Днепропетровская область',
      'Донецкая область',
      'Житомирская область',
      'Закарпатская область',
      'Запорожская область',
      'Ивано-Франковская область',
      'Киевская область',
      'Кировоградская область',
      'Луганская область',
      'Львовская область',
      'Николаевская область',
      'Одесская область',
      'Полтавская область',
      'Ровенская область',
      'Сумская область',
      'Тернопольская область',
      'Харьковская область',
      'Херсонская область',
      'Хмельницкая область',
      'Черкасская область',
      'Черниговская область',
      'Черновицкая область'
    ]
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :tours_and_user, dependent: :destroy
  has_many :tours, through: :tours_and_user
  has_many :comments, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :hotels, dependent: :destroy

  validates :username, presence: true
  validates :avatar, presence: true
  validates :count_of_hotels, numericality: { other_than: -1 }

  scope :created_tours, -> (user_id){ Tour.where(creator_id: user_id) }

  mount_uploader :avatar, AvatarUploader

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end
